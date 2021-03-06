if [[ -z $SSH_CONNECTION ]]; then
  export IS_REMOTE=false
else
  export IS_REMOTE=true
fi


IS_LINUX=false
IS_OSX=false
case `uname` in
  Linux)
    IS_LINUX=true
    ;;
  Darwin)
    IS_OSX=true
    ;;
esac
