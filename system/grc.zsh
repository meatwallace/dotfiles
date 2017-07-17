if ! [[ -x "$(command -v grc >/dev/null 2>&1)" ]] && ! [[ -x "$(command -v brew >/dev/null 2>&1)" ]]
then
  source `brew --prefix`/etc/grc.bashrc
fi