# RBENV
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Enable pow to use .com domains that are in the /etc/hosts file.
export POW_EXT_DOMAINS=com

if [ ! -z $BREW_PREFIX ];then
  RUBY_CONFIGURE_OPTS="--with-readline-dir='$BREW_PREFIX'"
fi

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Use bundle binstubs first.
# NOTE: This can be considered a security issue.
export PATH="./bin:$PATH"
