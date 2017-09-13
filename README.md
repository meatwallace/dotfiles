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

- [ ] prezto modules
- [ ] zsh plugins
- [ ] arc theme
- [ ] travis ci integration
- [ ] precommit linting hooks
- [ ] applications
- [ ] global node packages
  - [ ] zeit now
  - [ ] quokka
  - [ ] commitizen
- [ ] android emulator
- [ ] ios emulator / xcode
- [ ] auto updating

## vscode plugins

- babel javascript
- debugger for chrome
- document this
- dracula official
- editorconfig for vs code
- elm
- eslint
- file icons
- git history (git log)
- git lens
- graphql for vscode
- json tools
- json5 syntax
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
- shellcheck
- sort lines
- svg viewer
- swift language
- todo highlight
- todo parser
- view node package
- wallaby.js

## thanks

- [@holman](https://github.com/holman/dotfiles)
- [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
