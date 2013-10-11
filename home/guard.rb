
notification(:file, path: '.guard_result')

# On start => false?
::Bundler.with_clean_env do
  begin
    require 'guard/shell'
    guard(:shell) do
      watch('.guard_result') do
        ::Bundler.with_clean_env do
          `digicolor $(head -1 .guard_result) --blink`
        end
      end
    end
  rescue LoadError
    # TODO: A warning message?
  end
end

notification(:tmux, {
  :display_message => false,
  :success => 'colour150',
  :failed => 'colour174',
  :pending => 'colour179',
  :color_location => %w[status-left-bg pane-active-border-fg pane-border-fg],
}) if ENV['TMUX']

