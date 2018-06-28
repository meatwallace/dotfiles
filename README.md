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

- [ ] sublime installation & config
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
  - [ ] commitizen - commitlint?
- [ ] android emulator
- [ ] ios emulator / xcode
- [ ] auto updating

## thanks

- [@holman](https://github.com/holman/dotfiles)
- [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
