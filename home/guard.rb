
notification(:file, path: '.guard_result')

# On start => false?
::Bundler.with_clean_env do
  guard(:shell) do
    watch('.guard_result') do
      ::Bundler.with_clean_env do
        `digicolor $(head -1 .guard_result) --blink`
      end
    end
  end
end

notification(:tmux,
             :display_message => true,
             :display_message => false,
             :timeout => 6, # in seconds
             :default_message_format => '%s >> %s',
             # the first %s will show the title, the second the message
             # Alternately you can also configure *success_message_format*,
             # *pending_message_format*, *failed_message_format*
             :line_separator => ' > ', # since we are single line we need a separator
             :default_message_color  => 'colour0' # 255'
# :color_location => 'status-right-bg' # to customize which tmux element will change color
            )

