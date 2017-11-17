#!/bin/bash

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
echo "$1" | sudo -S chflags nohidden ~/Library
echo "$1" | sudo -S defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
echo "$1" | sudo -S defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
echo "$1" | sudo -S defaults write -g InitialKeyRepeat -int 13
echo "$1" | sudo -S defaults write -g KeyRepeat -int 1
echo "$1" | sudo -S defaults write -g QLPanelAnimationDuration -float 0
echo "$1" | sudo -S defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
echo "$1" | sudo -S defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
echo "$1" | sudo -S defaults write NSGlobalDomain AppleFontSmoothing -int 2
echo "$1" | sudo -S defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo "$1" | sudo -S defaults write NSGlobalDomain KeyRepeat -int 0
echo "$1" | sudo -S defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
echo "$1" | sudo -S defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
echo "$1" | sudo -S defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
echo "$1" | sudo -S defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
echo "$1" | sudo -S defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
echo "$1" | sudo -S defaults write com.apple.Dock autohide-delay -float 0
echo "$1" | sudo -S defaults write com.apple.LaunchServices LSQuarantine -bool false
echo "$1" | sudo -S defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
echo "$1" | sudo -S defaults write com.apple.Safari HomePage -string "about:blank"
echo "$1" | sudo -S defaults write com.apple.Safari IncludeDevelopMenu -bool true
echo "$1" | sudo -S defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
echo "$1" | sudo -S defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
echo "$1" | sudo -S defaults write com.apple.Safari SuppressSearchSuggestions -bool true
echo "$1" | sudo -S defaults write com.apple.Safari UniversalSearchEnabled -bool false
echo "$1" | sudo -S defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
echo "$1" | sudo -S defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25
echo "$1" | sudo -S defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
echo "$1" | sudo -S defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
echo "$1" | sudo -S defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
echo "$1" | sudo -S defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
echo "$1" | sudo -S defaults write com.apple.appstore WebKitDeveloperExtras -bool true
echo "$1" | sudo -S defaults write com.apple.desktopservices DSDontWriteNetworkStores true
echo "$1" | sudo -S defaults write com.apple.dock autohide -bool true
echo "$1" | sudo -S defaults write com.apple.dock autohide-time-modifier -float 0
echo "$1" | sudo -S defaults write com.apple.dock expose-animation-duration -float 0.1
echo "$1" | sudo -S defaults write com.apple.dock launchanim -bool false
echo "$1" | sudo -S defaults write com.apple.dock orientation -string "right"
echo "$1" | sudo -S defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
echo "$1" | sudo -S defaults write com.apple.finder AppleShowAllFiles YES
echo "$1" | sudo -S defaults write com.apple.finder DisableAllAnimations -bool true
echo "$1" | sudo -S defaults write com.apple.finder NewWindowTarget -string "PfDe"
echo "$1" | sudo -S defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
echo "$1" | sudo -S defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
echo "$1" | sudo -S defaults write com.apple.finder ShowPathbar -bool true
echo "$1" | sudo -S defaults write com.apple.finder ShowStatusBar -bool true
echo "$1" | sudo -S defaults write com.apple.finder ShowTabView -bool true
echo "$1" | sudo -S defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
echo "$1" | sudo -S defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
echo "$1" | sudo -S defaults write com.apple.mail DisableReplyAnimations -bool true
echo "$1" | sudo -S defaults write com.apple.mail DisableSendAnimations -bool true
echo "$1" | sudo -S defaults write com.apple.menuextra.battery ShowPercent -string "YES"
echo "$1" | sudo -S defaults write com.apple.menuextra.battery ShowTime -string "YES"
echo "$1" | sudo -S defaults write com.apple.menuextra.clock 'DateFormat' -string 'EEE H:mm'
echo "$1" | sudo -S defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
echo "$1" | sudo -S defaults write com.apple.screencapture disable-shadow -bool true
echo "$1" | sudo -S defaults write com.apple.screencapture location -string "${HOME}/Desktop"
echo "$1" | sudo -S defaults write com.apple.screencapture type -string "png"
echo "$1" | sudo -S defaults write com.apple.screensaver askForPassword -int 1
echo "$1" | sudo -S defaults write com.apple.screensaver askForPasswordDelay -int 0
echo "$1" | sudo -S defaults write com.apple.terminal StringEncodings -array 4
echo "$1" | sudo -S systemsetup -setcomputersleep Off > /dev/null
echo "$1" | sudo -S systemsetup -setrestartfreeze on

killall Dock

echo "$1" | sudo -S chmod -R 777 /var/tmp/;
echo "$1" | sudo -S chown -R $(whoami) /usr/local;

git clone https://github.com/kpango/dotfiles

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

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew tap homebrew/bundle

brew_init() {
    echo Initializing Brew
    brew update
    brew upgrade
    brew cleanup
    brew linkapps
}

brew_init

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

echo "$1" | sudo -S xcodebuild -license
xcode-select --install

brew bundle
brew link --force openssl
brew link --force readline
brew link --force bison
brew link --force libxml2
brew link --force libiconv
brew link --force libxslt

curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh

vboxmanage setproperty machinefolder $HOME/Documents/vagrant/VirtualBox VMs

echo "$1" | sudo -S chmod -R 777 $HOME/.atom 

# Go設定
go get -u github.com/nsf/gocode

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

PYTHON_CONFIGURE_OPTS="--enable-framework" $HOME/.anyenv/envs/pyenv/bin/pyenv install 2.7.14
PYTHON_CONFIGURE_OPTS="--enable-framework" $HOME/.anyenv/envs/pyenv/bin/pyenv install 3.7.0a2
$HOME/.anyenv/envs/pyenv/bin/pyenv global 2.7.14 3.7.0a2

reload_anyenv

$HOME/.anyenv/envs/pyenv/shims/pip install --upgrade pip;
$HOME/.anyenv/envs/pyenv/shims/pip2 install --upgrade pip;
$HOME/.anyenv/envs/pyenv/shims/pip3 install --upgrade pip;
$HOME/.anyenv/envs/pyenv/shims/pip install --upgrade websocket-client sexpdata neovim vim-vint conan
$HOME/.anyenv/envs/pyenv/shims/pip2 install --upgrade websocket-client sexpdata neovim vim-vint conan
$HOME/.anyenv/envs/pyenv/shims/pip3 install --upgrade websocket-client sexpdata neovim vim-vint conan

echo "$1" | sudo -S pip install git+https://github.com/idcf/cloudstack-api

# PHP設定

$HOME/.anyenv/bin/anyenv install phpenv

reload_anyenv

git clone https://github.com/php-build/php-build $HOME/.anyenv/envs/phpenv/plugins/php-build
git clone https://github.com/ngyuki/phpenv-composer.git $HOME/.anyenv/envs/phpenv/plugins/phpenv-composer

$HOME/.anyenv/envs/phpenv/bin/phpenv install -l

sed -i -e "1i configure_option -D \"--with-mysql\"" $HOME/.anyenv/envs/phpenv/plugins/php-build/share/php-build/definitions/master

PHP_BUILD_CONFIGURE_OPTS='--with-openssl=/usr/local/Cellar/openssl/*' $HOME/.anyenv/envs/phpenv/bin/phpenv install master --deep-clean

reload_anyenv

$HOME/.anyenv/envs/phpenv/bin/phpenv rehash

$HOME/.anyenv/envs/phpenv/plugins/phpenv-composer/libexec/composer

composer global require mkusher/padawan

# Ruby設定
echo "$1" | sudo -S rm -rf /usr/bin/ruby

$HOME/.anyenv/bin/anyenv install rbenv

reload_anyenv

$HOME/.anyenv/envs/rbenv/bin/rbenv install -l
$HOME/.anyenv/envs/rbenv/bin/rbenv install 2.5.0-preview1
$HOME/.anyenv/envs/rbenv/bin/rbenv global 2.5.0-preview1

echo "$1" | sudo -S ln -sfv $HOME/.anyenv/envs/rbenv/shims/ruby /usr/bin/ruby

reload_anyenv

echo "$1" | sudo -S chmod -R 755 $HOME/.anyenv/envs/rbenv/versions

echo "$1" | sudo -S $HOME/.anyenv/envs/rbenv/shims/gem install sass --no-rdoc --no-ri
echo "$1" | sudo -S $HOME/.anyenv/envs/rbenv/shims/gem install compass --no-rdoc --no-ri
echo "$1" | sudo -S $HOME/.anyenv/envs/rbenv/shims/gem install nokogiri --no-rdoc --no-ri -- --use-system-libraries --with-iconv-dir="$(brew --prefix libiconv)" --with-xml2-config="$(brew --prefix libxml2)/bin/xml2-config" --with-xslt-config="$(brew --prefix libxslt)/bin/xslt-config"
echo "$1" | sudo -S $HOME/.anyenv/envs/rbenv/shims/gem install rails --no-rdoc --no-ri
echo "$1" | sudo -S $HOME/.anyenv/envs/rbenv/shims/gem install cocoapods --pre --no-rdoc --no-ri
echo "$1" | sudo -S $HOME/.anyenv/envs/rbenv/shims/gem install neovim --no-rdoc --no-ri
echo "$1" | sudo -S $HOME/.anyenv/envs/rbenv/shims/gem update --no-rdoc --no-ri

# node設定
$HOME/.anyenv/bin/anyenv install ndenv

reload_anyenv

$HOME/.anyenv/envs/ndenv/bin/ndenv install -l
$HOME/.anyenv/envs/ndenv/bin/ndenv install v9.2.0
$HOME/.anyenv/envs/ndenv/bin/ndenv global v9.2.0

reload_anyenv

$HOME/.anyenv/envs/ndenv/shims/npm install -g less jsctags jshint htmlhint js-beautify eslint eslint_d babel-eslint eslint-config-airbnb eslint-plugin-import eslint-plugin-react eslint-plugin-jsx-a11y source-map-support webpack csslint stylelint pug-cli markdown-pdf
# Erlang設定

$HOME/.anyenv/bin/anyenv install erlenv

reload_anyenv

wget http://www.erlang.org/download/otp_src_19.3.tar.gz
tar zxf otp_src_19.3.tar.gz
cd otp_src_19.3
./configure --enable-dynamic-ssl-lib --with-ssl=/usr/local/opt/openssl --prefix=$HOME/.anyenv/envs/erlenv/releases/19.3
make -j 4
make install
cd
rm -rf otp_src_19.3*

$HOME/.anyenv/envs/erlenv/bin/erlenv global 19.3
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
$HOME/.anyenv/envs/crenv/bin/crenv install 0.23.1
$HOME/.anyenv/envs/crenv/bin/crenv global 0.23.1
$HOME/.anyenv/envs/crenv/bin/crenv rehash

reload_anyenv

# Scala設定
$HOME/.anyenv/bin/anyenv install sbtenv

$HOME/.anyenv/bin/anyenv install scalaenv

git clone git://github.com/mazgi/playenv.git $HOME/.anyenv/envs/playenv

reload_anyenv

$HOME/.anyenv/envs/sbtenv/bin/sbtenv install -l
$HOME/.anyenv/envs/sbtenv/bin/sbtenv install sbt-1.0.3
$HOME/.anyenv/envs/sbtenv/bin/sbtenv global sbt-1.0.3
$HOME/.anyenv/envs/sbtenv/bin/sbtenv rehash

reload_anyenv

$HOME/.anyenv/envs/scalaenv/bin/scalaenv install -l
$HOME/.anyenv/envs/scalaenv/bin/scalaenv install scala-2.13.0-M2
$HOME/.anyenv/envs/scalaenv/bin/scalaenv global scala-2.13.0-M2
$HOME/.anyenv/envs/scalaenv/bin/scalaenv rehash

reload_anyenv

$HOME/.anyenv/envs/playenv/bin/playenv install -l
$HOME/.anyenv/envs/playenv/bin/playenv install play-2.2.4
$HOME/.anyenv/envs/playenv/bin/playenv global play-2.2.4
$HOME/.anyenv/envs/playenv/bin/playenv rehash

reload_anyenv

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
curl -sSf https://static.rust-lang.org/rustup.sh | sh -s -- --prefix=/usr/local --channel=nightly
/usr/local/bin/cargo install --git https://github.com/phildawes/racer.git
/usr/local/bin/cargo install --git https://github.com/rust-lang-nursery/rustfmt
/usr/local/bin/cargo install ripgrep
/usr/local/bin/cargo install --no-default-features --git https://github.com/ogham/exa
/usr/local/bin/cargo install --no-default-features --git https://github.com/sharkdp/fd

# install Neovim

echo "$1" | sudo -S rm -rf $HOME/neovim
echo "$1" | sudo -S rm -rf /usr/local/bin/nvim
echo "$1" | sudo -S rm -rf /usr/local/share/nvim
rm -rf "$HOME/.config/gocode";
rm -rf "$HOME/.config/nvim/autoload";
rm -rf "$HOME/.config/nvim/ftplugin";
rm -rf "$HOME/.config/nvim/log";
rm -rf "$HOME/.config/nvim/plugged";
rm "$HOME/.nvimlog";
rm "$HOME/.viminfo";
cd $HOME
git clone https://github.com/neovim/neovim
cd neovim
rm -r build
make clean
make CMAKE_BUILD_TYPE=Release
secho "$1" | sudo -S make install
cd ..
rm -rf neovim
nvim +UpdateRemotePlugins +PlugInstall +PlugUpdate +PlugUpgrade +PlugClean +GoInstallBinaries +GoUpdateBinaries +qall


brew_init

git config --global user.name "$(whoami)"
git config --global user.email "$(whoami)@gmail.com"

update

sudo chmod -R 755 /usr/local/share/zsh
echo "$1" | sudo -S sh -c "echo '$(which zsh)' >> /etc/shells"
chsh -s $(which zsh);
echo "$1" | sudo -S open ./monokai.terminal
echo "$1" | sudo -S chsh -s $(which zsh);
echo "$1" | sudo -S reboot;
