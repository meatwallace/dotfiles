if [[ "$(uname -s)" == "Darwin" ]]
then
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
else
  # TODO: path for linux
fi
