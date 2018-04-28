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
- [ ] hosted
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
- bracket pair colorizer
- carbon-now-sh
- debugger for chrome
- dracula official
- editorconfig for vs code
- eslint
- flow language support
- git history
- gitlens - git supercharged
- graphql for vscode
- json tools
- json5 syntax
- latest typescript and javascript grammar
- markdown preview enhanced
- markdownlint
- material icon theme
- npm
- npm intellisense
- path intellisense
- prettier - code formatter
- project manager
- quokka
- react native tools
- shellcheck
- sort lines
- sort-imports
- svg viewer
- svg
- todo highlight
- todo parser
- todo tree
- view node package
- wallaby.js

## thanks

- [@holman](https://github.com/holman/dotfiles)
- [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
