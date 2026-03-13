# reference: https://github.com/romkatv/powerlevel10k/issues/2212
() {
    function prompt_mise() {
        local plugins=("${(@f)$(mise ls --local 2>/dev/null | awk '!/\(symlink\)/ && $3!="~/.tool-versions" && $3!="~/.config/mise/config.toml" {print $1, $2}')}")
        local plugin
        for plugin in ${(k)plugins}; do
            local parts=("${(@s/ /)plugin}")
            local tool=${(U)parts[1]}
            local version=${parts[2]}

            # only include tools that have icons
            local icon_var="POWERLEVEL9K_${tool}_ICON"
            if [[ -n "${(P)icon_var}" ]] || [[ -n "${icons[${tool}_ICON]}" ]]; then
                p10k segment -r -i "${tool}_ICON" -s $tool -t "$version"
            fi
        done
    }

    # Colors
    typeset -g POWERLEVEL9K_MISE_FOREGROUND=66
    typeset -g POWERLEVEL9K_MISE_RUBY_FOREGROUND=9 # 168
    typeset -g POWERLEVEL9K_MISE_PYTHON_FOREGROUND=37
    typeset -g POWERLEVEL9K_MISE_GOLANG_FOREGROUND=37
    typeset -g POWERLEVEL9K_MISE_NODEJS_FOREGROUND=70
    typeset -g POWERLEVEL9K_MISE_RUST_FOREGROUND=37
    typeset -g POWERLEVEL9K_MISE_DOTNET_CORE_FOREGROUND=134
    typeset -g POWERLEVEL9K_MISE_FLUTTER_FOREGROUND=38
    typeset -g POWERLEVEL9K_MISE_LUA_FOREGROUND=32
    typeset -g POWERLEVEL9K_MISE_JAVA_FOREGROUND=32
    typeset -g POWERLEVEL9K_MISE_PERL_FOREGROUND=67
    typeset -g POWERLEVEL9K_MISE_ERLANG_FOREGROUND=125
    typeset -g POWERLEVEL9K_MISE_ELIXIR_FOREGROUND=129
    typeset -g POWERLEVEL9K_MISE_POSTGRES_FOREGROUND=31
    typeset -g POWERLEVEL9K_MISE_PHP_FOREGROUND=99
    typeset -g POWERLEVEL9K_MISE_HASKELL_FOREGROUND=172
    typeset -g POWERLEVEL9K_MISE_JULIA_FOREGROUND=70

    # Substitute the default asdf prompt element
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=("${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]/asdf/mise}")
  }
