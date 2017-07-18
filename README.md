# dotfiles

## install

```bash
# create our directory
mkdir -p ~/projects/dotfiles && cd $_

# grab dotfiles
curl --progress-bar --location https://github.com/meatwallace/dotfiles/tarball/master | tar -xzv --strip-components 1

# link
ln -s ~/projects/dotfiles/ ~/.dotfiles

# initialize
script/bootstrap

# map back to repo
git init .
git remote add -t \* -f origin git@github.com:meatwallace/dotfiles.git
git add .
git checkout master
```

## todo

- [ ] [vs code settings](https://code.visualstudio.com/docs/getstarted/settings)
- [ ] prezto modules
- [ ] zsh plugins
- [ ] arc theme
- [ ] applications
- [ ] global node packages
  - [ ] zeit now
  - [ ] quokka
  - [ ] commitizen
- [ ] android emulator
- [ ] ios emulator / xcode
- [ ] auto updating

## vscode plugins

- an old hope theme
- auto-open markdown preview
- code spellchecker
- codemetrics
- debugger for chrome
- document this
- editorconfig for vs code
- elm
- eslint
- file icons
- git history (git log)
- git lens
- js refactorings
- json tools
- language support for java
- markdown toc
- markdownlint
- npm
- npm intellisense
- path intellisense
- prettier
- project manager
- quokka
- react native tools
- regex previewer
- search node_modules
- sort lines
- svg reviewer
- swift language
- todo highlight
- todo parser
- version lens
- view node package
- wallaby.js

## thanks

- [@holman](https://github.com/holman/dotfiles)
- [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
