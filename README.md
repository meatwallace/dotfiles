# dotfiles

## install

```sh
# the dream
curl --location https://meatbox.one | sh
```

```sh
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
