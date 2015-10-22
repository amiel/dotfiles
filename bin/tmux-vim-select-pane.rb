#!/usr/bin/env ruby

# See https://github.com/amiel/vim-tmux-navigator/blob/master/README.md for
# installation instructions.


Window = Struct.new(:width, :height, :layout, :zoomed)

PaneInfo = Struct.new(:id, :width, :height, :window, :current_command, :x, :y) do
  def initialize(*)
    super
    set_layout
  end

  def set_layout
    # set_layout: "8902,364x83,0,0[364x16,0,0,0,364x66,0,17{181x66,0,17,4,91x66,182,17,5,90x66,274,17,10}]"
    matches = window.layout.match(/\d+x\d+,(\d+),(\d+),#{id}/)
    self.x = matches[1].to_i
    self.y = matches[2].to_i
  end

  def vim?
    current_command == 'vim'
  end

  def top?
    y.zero?
  end

  def bottom?
    y + height == window.height
  end

  def left?
    x.zero?
  end

  def right?
    x + width == window.width
  end
end

class TMUX

  def get_tmux_thing(thing)
    `tmux display-message -p '\#{#{thing}}'`.strip
  end

  def window
    @_window ||= Window.new(
      get_tmux_thing('window_width').to_i,
      get_tmux_thing('window_height').to_i,
      get_tmux_thing('window_layout'),
      get_tmux_thing('window_zoomed_flag').to_i == 1,
    )
  end

  def pane
    @_pane ||= PaneInfo.new(
      get_tmux_thing('pane_id').gsub(/\%/,'').to_i,
      get_tmux_thing('pane_width').to_i,
      get_tmux_thing('pane_height').to_i,
      window,
      current_pane_command,
    )
  end

  def current_pane_command
    File.basename get_tmux_thing('pane_current_command')
  end
end

def should_zoom?(arg, pane)
  return true if pane.window.zoomed
  return true if arg == '-L' && pane.left?
  return true if arg == '-R' && pane.right?
  return true if arg == '-U' && pane.top?
  return true if arg == '-D' && pane.bottom?

  false
end

tmux = TMUX.new
pane = tmux.pane

arg = ARGV[0]
if should_zoom?(arg, pane)
  style = :zoom
  command = 'tmux resize-pane -Z'
else
  style = :tmux
  command = "tmux select-pane #{arg}"
end

if pane.vim?
  # wincmd = arg.sub('-', '').tr 'lLDUR', 'phjkl'

  commands ||= {
    tmux: { 'U' => 'F3', 'R' => 'F4', 'D' => 'F2', 'L' => 'F1' },
    zoom: { 'U' => 'F7', 'R' => 'F8', 'D' => 'F6', 'L' => 'F5' },
    # I tried to use a meta prefix to make these "secret" overrides
    # even less likely to override user-defined mappings, but I couldn't
    # get it working.
    # zoom: { 'U' => 'M-<F5>', 'R' => 'M-<F6>', 'D' => 'M-<F7>', 'L' => 'M-<F8>' },
  }

  keycmd = commands[style][arg.sub('-', '')]

  `tmux send-keys "#{keycmd}"`
else
  `#{command}`
end

