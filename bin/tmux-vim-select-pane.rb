#!/usr/bin/env ruby

Window = Struct.new(:width, :height, :layout)

PaneInfo = Struct.new(:id, :width, :height, :window, :current_command, :x, :y) do
  def initialize(*)
    super
    set_layout
  end

  def set_layout
    matches = window.layout.match(/#{width}x#{height},(\d+),(\d+),#{id}/)
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

tmux = TMUX.new
pane = tmux.pane

arg = ARGV[0]
if arg == '-L' && pane.left? || arg == '-R' && pane.right? || arg == '-U' && pane.top? || arg == '-D' && pane.bottom?
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
    # zoom: { 'U' => 'M-<F5>', 'R' => 'M-<F6>', 'D' => 'M-<F7>', 'L' => 'M-<F8>' },
  }

  keycmd = commands[style][arg.sub('-', '')]

  `tmux send-keys "#{keycmd}"`

  # `tmux send-keys C-#{wincmd}`

#   `tmux send-keys ":let nr = winnr() | wincmd #{wincmd}" C-m`
#   `tmux send-keys ":if nr == winnr() | silent call system(\\"#{command}\\") | end"`
#   sleep 0.1
#   `tmux send-keys C-m ':echo "\\r"' C-m`
else
  `#{command}`
end

