# RBENV
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Enable pow to use .com domains that are in the /etc/hosts file.
export POW_EXT_DOMAINS=com

# Use bundle binstubs first.
# NOTE: This can be considered a security issue.
# export PATH="./bin:$PATH"
