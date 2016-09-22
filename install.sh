#!/bin/sh

echo "$1" | sudo -S -v

while true; do echo "$1" | sudo -S -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "$1" | sudo -S pmset -a standbydelay 86400

echo "$1" | sudo -S pmset -a hibernatemode 0
echo "$1" | sudo -S rm /private/var/vm/sleepimage
echo "$1" | sudo -S touch /private/var/vm/sleepimage
echo "$1" | sudo -S chflags uchg /private/var/vm/sleepimage
echo "$1" | sudo -S mkdir -p /usr/local

# Disable the sudden motion sensor as it’s not useful for SSDs
echo "$1" | sudo -S pmset -a sms 0

echo "$1" | sudo -S nvram SystemAudioVolume=" "

defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "$1" | sudo -S defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "YES"
defaults write com.apple.menuextra.clock 'DateFormat' -string 'EEE H:mm'

defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

defaults write com.apple.finder ShowStatusBar -bool true

defaults write com.apple.finder ShowPathbar -bool true

defaults write com.apple.finder ShowTabView -bool true

chflags nohidden ~/Library

defaults write com.apple.finder AppleShowAllFiles YES

echo "$1" | sudo -S systemsetup -setrestartfreeze on

echo "$1" | sudo -S systemsetup -setcomputersleep Off > /dev/null

defaults write com.apple.desktopservices DSDontWriteNetworkStores true

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

defaults write NSGlobalDomain AppleShowAllExtensions -bool true

defaults write com.apple.dock orientation -string "right"

defaults write com.apple.dock autohide -bool true

defaults write -g InitialKeyRepeat -int 13

defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture type -string "png"

defaults write com.apple.screencapture disable-shadow -bool true

defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "$1" | sudo -S defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

defaults write -g QLPanelAnimationDuration -float 0

defaults write com.apple.dock launchanim -bool false

defaults write com.apple.dock expose-animation-duration -float 0.1

defaults write com.apple.Dock autohide-delay -float 0

defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

defaults write com.apple.appstore WebKitDeveloperExtras -bool true

defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

defaults write com.apple.terminal StringEncodings -array 4

defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari HomePage -string "about:blank"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

killall Dock

echo "$1" | sudo -S chmod -R 777 /var/tmp/;
echo "$1" | sudo -S chown -R $(whoami) /usr/local;

git clone https://github.com/Y-Kato-Badminton/dotfiles

rm -rf $HOME/.zshrc;
cp ./dotfiles/zshrc $HOME/.zshrc;
rm -rf $HOME/.config
mkdir -p $HOME/.config/nvim/tmp
mkdir -p $HOME/.config/nvim/colors
cp ./dotfiles/init.vim $HOME/.config/nvim/
cp ./dotfiles/monokai.vim $HOME/.config/nvim/colors/
cp ./Ricty-Regular.ttf $HOME/Library/Fonts/
mv $HOME/.tmux.conf $HOME/.tmux.conf.back
cp ./dotfiles/tmux.conf $HOME/.tmux.conf
mv $HOME/.eslintrc $HOME/.eslintrc.back
cp ./dotfiles/eslintrc $HOME/.eslintrc
mv $HOME/.esformatter $HOME/.esformatter.back
cp ./dotfiles/esformatter $HOME/.esformatter
mv $HOME/.gitignore $HOME/.gitignore.back
cp ./dotfiles/gitignore $HOME/.gitignore
mv $HOME/.gitattributes $HOME/.gitattributes.back
cp ./dotfiles/gitattributes $HOME/.gitattributes
mv $HOME/.gitconfig $HOME/.gitconfig.back
cp ./dotfiles/gitconfig $HOME/.gitconfig

set_font() {
    osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"$1\""
    osascript -e "tell application \"Terminal\" to set the font size of window 1 to $2"
}

set_font "Ricty" 13.5

echo "$1" | sudo -S xcodebuild -license

xcode-select --install

curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew tap caskroom/cask
brew tap homebrew/versions
brew tap homebrew/dupes

brew_init() {
    echo Initializing Brew
    brew update
    brew upgrade --all
    brew cleanup
    brew linkapps
}

brew_init

install_package() {
    echo EXECUTING: brew install $1 $2
    brew install $1 $2
    [ $? -ne 0 ] && failed_items="failed_items $1" # package failed to install.
}

failed_items=""

install_cask_package() {
    echo EXECUTING: brew cask install $1
    brew cask install $1
    [ $? -ne 0 ] && failed_items="failed_items $1"  # package failed to install.
}

reload_anyenv() {
    export PROGRAMMING=$HOME/Documents/Programming;
    export GOPATH=$PROGRAMMING/go;
    export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/share/npm/bin:/usr/X11/bin:/usr/local/git/bin:/opt/local/bin:$HOME/.cabal/bin:$GOPATH/bin:$JAVA_HOME/bin:$JRE_HOME:$PATH;
    if [ -d $HOME/.anyenv ] ; then
        export PATH="$HOME/.anyenv/bin:$PATH"
        eval "$(anyenv init -)"
        eval "$(anyenv init - zsh)"
        for D in `\ls $HOME/.anyenv/envs`
        do
            export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
        done
    fi
}

install_package xz '  --universal'
install_package pkg-config ''
install_package makedepend ''
install_package libressl ''
install_package openssl '  --universal'
brew link openssl --force
install_package autoconf ''
install_package automake ''
install_package libtool '  --universal'
install_package pcre '  --universal'
install_package readline ''
brew link readline --force

brew tap caskroom/cask
install_cask_package java ''

install_package gettext '  --universal'
install_package git '  --HEAD'
install_package wget '  --with-libressl --with-pcre'
install_package gdbm '  --universal --with-libgdbm-compat'
install_package zsh ''
install_package cmake '  --with-completion --without-docs --HEAD'
install_package sphinx-doc ''
install_package neovim/neovim/neovim '  --HEAD'
install_package ctags ''
install_package jpeg '  --universal'
install_package libpng '  --universal'
install_package libffi ''
install_package freetype '  --universal'
install_package re2c ''
install_package mhash ''
install_package mcrypt ''
install_package mercurial ''
install_package bison ''
brew link bison --force
install_package tig ''
install_package doxygen ' --HEAD'
install_package libevent ' --HEAD'
install_package tmux ' --HEAD'
install_package oniguruma ''
install_package jq ''
install_package libssh2 ' --with-libressl --HEAD'
install_cask_package xquartz ''
install_package graphviz '  --with-freetype --with-x11 -HEAD'
install_package sourcekitten ' --HEAD'
install_package ag ' --HEAD'
install_package axel ' --HEAD'
install_package texinfo ''
install_package gmp ' --c++11'
install_package coreutils ' --with-gmp'
install_package tree ''
install_package maven ''
install_package lua ' --universal --with-completion'
install_package ag ' --HEAD'
install_package ranger ''
install_package go ''
install_package ocaml ' --with-flambda --with-x11'
install_package llvm ' --universal --with-all-targets --with-graphviz --with-clang --with-ocaml --with-python --with-shared-libs --with-toolchain --HEAD'
install_package mariadb ''

# Go設定
go get -u -v github.com/Masterminds/glide
go get -u -v github.com/alecthomas/gometalinter
go get -u -v github.com/golang/lint/golint
go get -u -v github.com/jstemmer/gotags
go get -u -v github.com/kisielk/gotool
go get -u -v github.com/mattn/files
go get -u -v github.com/mattn/jvgrep
go get -u -v github.com/motemen/go-iferr/cmd/goiferr
go get -u -v github.com/nsf/gocode
go get -u -v github.com/peco/peco/cmd/peco
go get -u -v github.com/zmb3/gogetdoc
go get -u -v golang.org/x/tools/cmd/cover
go get -u -v golang.org/x/tools/cmd/godef
go get -u -v golang.org/x/tools/cmd/godoc
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v golang.org/x/tools/cmd/oracle
go get -u -v golang.org/x/tools/cmd/vet
go get -u -v sourcegraph.com/sqs/goreturns

go install github.com/Masterminds/glide
go install github.com/alecthomas/gometalinter
go install github.com/golang/lint/golint
go install github.com/jstemmer/gotags
go install github.com/kisielk/gotool
go install github.com/mattn/jvgrep
go install github.com/motemen/go-iferr/cmd/goiferr
go install github.com/nsf/gocode
go install github.com/peco/peco/cmd/peco
go install github.com/zmb3/gogetdoc
go install golang.org/x/tools/cmd/cover
go install golang.org/x/tools/cmd/godef
go install golang.org/x/tools/cmd/godoc
go install golang.org/x/tools/cmd/goimports
go install golang.org/x/tools/cmd/gorename
go install golang.org/x/tools/cmd/guru
go install golang.org/x/tools/cmd/oracle
go install golang.org/x/tools/cmd/vet
go install sourcegraph.com/sqs/goreturns

$GOPATH/bin/gocode set autobuild true
$GOPATH/bin/gocode set lib-path $GOPATH/pkg/darwin_amd64/
$GOPATH/bin/gocode set propose-builtins true

# anyenv install
rm -rf $HOME/.anyenv
git clone https://github.com/riywo/anyenv $HOME/.anyenv
mkdir -p $HOME/.anyenv/plugins
git clone https://github.com/znz/anyenv-update.git $HOME/.anyenv/plugins/anyenv-update
git clone git://github.com/aereal/anyenv-exec.git $HOME/.anyenv/plugins/anyenv-exe
git clone https://github.com/znz/anyenv-git.git $HOME/.anyenv/plugins/anyenv-git

reload_anyenv

$HOME/.anyenv/bin/anyenv install -l

# Python設定
$HOME/.anyenv/bin/anyenv install pyenv

mkdir -p $HOME/.anyenv/envs/pyenv/plugins

git clone git://github.com/yyuu/pyenv-virtualenv.git $HOME/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
git clone https://github.com/yyuu/pyenv-pip-rehash.git $HOME/.anyenv/envs/pyenv/plugins/pyenv-pip-rehash

reload_anyenv

$HOME/.anyenv/envs/pyenv/bin/pyenv install 2.7.12
$HOME/.anyenv/envs/pyenv/bin/pyenv install 3.5.2
$HOME/.anyenv/envs/pyenv/bin/pyenv global 2.7.12 3.5.2

reload_anyenv

$HOME/.anyenv/envs/pyenv/shims/pip install --upgrade pip;
$HOME/.anyenv/envs/pyenv/shims/pip2 install --upgrade pip;
$HOME/.anyenv/envs/pyenv/shims/pip3 install --upgrade pip;
$HOME/.anyenv/envs/pyenv/shims/pip install --upgrade websocket-client sexpdata neovim
$HOME/.anyenv/envs/pyenv/shims/pip2 install --upgrade websocket-client sexpdata neovim
$HOME/.anyenv/envs/pyenv/shims/pip3 install --upgrade websocket-client sexpdata neovim

echo "$1" | sudo -S pip install git+https://github.com/idcf/cloudstack-api

# PHP設定
install_package libxml2 '  --universal --with-python --HEAD'
brew link --force libxml2

$HOME/.anyenv/bin/anyenv install phpenv

reload_anyenv

git clone https://github.com/php-build/php-build $HOME/.anyenv/envs/phpenv/plugins/php-build
git clone https://github.com/ngyuki/phpenv-composer.git $HOME/.anyenv/envs/phpenv/plugins/phpenv-composer

$HOME/.anyenv/envs/phpenv/bin/phpenv install -l

PHP_BUILD_CONFIGURE_OPTS='--with-openssl=/usr/local/Cellar/openssl/*' $HOME/.anyenv/envs/phpenv/bin/phpenv install master --deep-clean

reload_anyenv

$HOME/.anyenv/envs/phpenv/bin/phpenv rehash

$HOME/.anyenv/envs/phpenv/plugins/phpenv-composer/libexec/composer

# Ruby設定
echo "$1" | sudo -S rm -rf /usr/bin/ruby

install_package libiconv '  --universal'
brew link --force libiconv
install_package libxslt ''
brew link --force libxslt

$HOME/.anyenv/bin/anyenv install rbenv

reload_anyenv

$HOME/.anyenv/envs/rbenv/bin/rbenv install -l
$HOME/.anyenv/envs/rbenv/bin/rbenv install 2.4.0-dev
$HOME/.anyenv/envs/rbenv/bin/rbenv global 2.4.0-dev

echo "$1" | sudo -S ln -sfv $HOME/.anyenv/envs/rbenv/shims/ruby /usr/bin/ruby

reload_anyenv

echo "$1" | sudo -S chmod -R 755 $HOME/.anyenv/envs/rbenv/versions

$HOME/.anyenv/envs/rbenv/shims/gem install sass --no-rdoc --no-ri
$HOME/.anyenv/envs/rbenv/shims/gem install compass --no-rdoc --no-ri
$HOME/.anyenv/envs/rbenv/shims/gem install nokogiri --no-rdoc --no-ri -- --use-system-libraries --with-iconv-dir="$(brew --prefix libiconv)" --with-xml2-config="$(brew --prefix libxml2)/bin/xml2-config" --with-xslt-config="$(brew --prefix libxslt)/bin/xslt-config"
$HOME/.anyenv/envs/rbenv/shims/gem install rails --no-rdoc --no-ri
$HOME/.anyenv/envs/rbenv/shims/gem install cocoapods --pre --no-rdoc --no-ri
$HOME/.anyenv/envs/rbenv/shims/gem update --no-rdoc --no-ri

# node設定
$HOME/.anyenv/bin/anyenv install ndenv

reload_anyenv

$HOME/.anyenv/envs/ndenv/bin/ndenv install -l
$HOME/.anyenv/envs/ndenv/bin/ndenv install v6.4.0
$HOME/.anyenv/envs/ndenv/bin/ndenv global v6.4.0

reload_anyenv

$HOME/.anyenv/envs/ndenv/shims/npm install -g less jsctags js-beautify eslint-config-airbnb eslint-plugin-import eslint-plugin-react eslint-plugin-jsx-a11y eslint babel-eslint

# Erlang設定
install_package unixodbc '  --universal'
install_package libtiff ' --universal'
install_package wxmac '  --universal --with-static --with-stl'
install_package fop '  --universal'

$HOME/.anyenv/bin/anyenv install erlenv

reload_anyenv

wget http://www.erlang.org/download/otp_src_19.0.tar.gz
tar zxf otp_src_19.0.tar.gz
cd otp_src_19.0
./configure --enable-dynamic-ssl-lib --with-ssl=/usr/local/opt/openssl --prefix=$HOME/.anyenv/envs/erlenv/releases/19.0
make -j 4
make install
cd
rm -rf otp_src_19.0*

$HOME/.anyenv/envs/erlenv/bin/erlenv global 19.0
$HOME/.anyenv/envs/erlenv/bin/erlenv rehash

reload_anyenv

# Elixir設定
$HOME/.anyenv/bin/anyenv install exenv

reload_anyenv

$HOME/.anyenv/envs/exenv/bin/exenv install -l
$HOME/.anyenv/envs/exenv/bin/exenv install master
$HOME/.anyenv/envs/exenv/bin/exenv global master
$HOME/.anyenv/envs/exenv/bin/exenv rehash

reload_anyenv

# Crystal設定
$HOME/.anyenv/bin/anyenv install crenv

reload_anyenv

$HOME/.anyenv/envs/crenv/bin/crenv install -l
$HOME/.anyenv/envs/crenv/bin/crenv install 0.18.7
$HOME/.anyenv/envs/crenv/bin/crenv global 0.18.7
$HOME/.anyenv/envs/crenv/bin/crenv rehash

reload_anyenv

# Scala設定
$HOME/.anyenv/bin/anyenv install sbtenv

$HOME/.anyenv/bin/anyenv install scalaenv

git clone git://github.com/mazgi/playenv.git $HOME/.anyenv/envs/playenv

reload_anyenv

$HOME/.anyenv/envs/sbtenv/bin/sbtenv install -l
$HOME/.anyenv/envs/sbtenv/bin/sbtenv install sbt-0.13.12
$HOME/.anyenv/envs/sbtenv/bin/sbtenv global sbt-0.13.12
$HOME/.anyenv/envs/sbtenv/bin/sbtenv rehash

reload_anyenv

$HOME/.anyenv/envs/scalaenv/bin/scalaenv install -l
$HOME/.anyenv/envs/scalaenv/bin/scalaenv install scala-2.12.0-M4
$HOME/.anyenv/envs/scalaenv/bin/scalaenv global scala-2.12.0-M4
$HOME/.anyenv/envs/scalaenv/bin/scalaenv rehash

reload_anyenv

$HOME/.anyenv/envs/playenv/bin/playenv install -l
$HOME/.anyenv/envs/playenv/bin/playenv install play-2.2.4
$HOME/.anyenv/envs/playenv/bin/playenv global play-2.2.4
$HOME/.anyenv/envs/playenv/bin/playenv rehash

reload_anyenv

install_package ghc ''

# anyenv install hsenv Haskell の開発にはStackを使うこと! https://github.com/commercialhaskell/stack
curl -sSL https://get.haskellstack.org/ | sh

stack update
stack install happy
stack install cabal-install
stack install ghc-mod
stack update

# anyenv clean
$HOME/.anyenv/bin/anyenv update
$HOME/.anyenv/bin/anyenv version
$HOME/.anyenv/bin/anyenv git gc

reload_anyenv

# Install Nim
cd
git clone https://github.com/nim-lang/Nim.git
echo "$1" | sudo -S mv ./Nim /usr/local/bin/
cd /usr/local/bin/Nim
git clone --depth 1 https://github.com/nim-lang/csources
cd csources && sh build.sh
export PATH=/usr/local/bin/Nim/bin:$PATH
cd ..
bin/nim c koch
./koch boot -d:release
nim e install_nimble.nims
git clone https://github.com/nim-lang/nimsuggest
cd nimsuggest
nimble build
nimble install nimsuggest
cd

# Install Rust
curl -sSf https://static.rust-lang.org/rustup.sh | sh -s -- --channel=nightly
/usr/local/bin/cargo install --git https://github.com/phildawes/racer.git
/usr/local/bin/cargo install --git https://github.com/rust-lang-nursery/rustfmt


nvim +UpdateRemotePlugins +PlugInstall +PlugUpdate +PlugUpgrade +PlugClean +GoInstallBinaries +GoUpdateBinaries +qall

# Install Brew Casks
install_package shellcheck ''

install_cask_package alfred ''
install_cask_package android-studio ''
install_cask_package appcleaner ''
install_cask_package appcode ''
install_cask_package arduino ''
install_cask_package atom ''
install_cask_package bettertouchtool ''
echo "$1" | sudo -S chmod -R 777 $HOME/.atom 
install_cask_package ccleaner ''
install_cask_package clion ''
install_cask_package dash ''
install_cask_package eclipse-jee ''
install_cask_package evernote ''
install_cask_package google-chrome ''
install_cask_package google-drive ''
install_cask_package intellij-idea ''
install_cask_package mysqlworkbench ''
install_cask_package netbeans ''
install_cask_package onyx ''
install_cask_package phpstorm ''
install_cask_package pycharm ''
install_cask_package rubymine ''
install_cask_package skype ''
install_cask_package slack ''
install_cask_package tunnelblick ''
install_cask_package virtualbox ''
vboxmanage setproperty machinefolder $HOME/Documents/vagrant/VirtualBox VMs
install_cask_package vagrant ''
install_cask_package vmware-fusion ''
install_cask_package webstorm ''

brew_init

#apm install --packages-file ./packages.list

git config --global user.name "$(whoami)"
git config --global user.email "$(whoami)@gmail.com"

update

echo "$1" | sudo -S sh -c "echo '$(which zsh)' >> /etc/shells"
chsh -s $(which zsh);
echo "$1" | sudo -S open ./monokai.terminal
echo "$1" | sudo -S chsh -s $(which zsh);
echo "$1" | sudo -S reboot;
