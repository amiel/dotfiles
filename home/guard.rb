
notification(:file, path: File.expand_path('~/Dropbox/dotfiles/guard_result/result/guard_result'))

notification(:tmux, {
  :display_message => false,
  :success => 'colour150',
  :failed => 'colour174',
  :pending => 'colour179',
  :color_location => %w[status-left-bg status-left-fg pane-active-border-fg pane-border-fg],
}) if ENV['TMUX']

