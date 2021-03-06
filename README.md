[![Build Status](https://travis-ci.org/purcell/emacs.d.png?branch=master)](https://travis-ci.org/purcell/emacs.d)

# A reasonable Emacs config

This is my emacs configuration tree, continually used and tweaked
since 2000, and it may be a good starting point for other Emacs users,
especially those who are web developers. These days it's somewhat
geared towards OS X, but it is known to also work on Linux and
Windows.

Emacs itself comes with support for many programming languages. This
config adds improved defaults and extended support for the following:

* Ruby / Ruby on Rails
* CSS / LESS / SASS / SCSS
* HAML / Markdown / Textile / ERB
* Clojure (with Cider and nRepl)
* Javascript / Coffeescript
* Python
* PHP
* Haskell
* Elm
* Erlang
* Common Lisp (with Slime)
* Perl
* Bash

In particular, there's a nice config for *tab autocompletion*, and
`flycheck` is used to immediately highlight syntax errors in Ruby, HAML,
Python, Javascript, PHP and a number of other languages.

## Further features

* Mail
 * A full gnus setup, easy to use (look at ~/.gnus after make install)
 * A simple OfflineIMAP configuration (look at ~/.offlineimaprc and
   ~/.offineimap.py after make install)
 * Please set the pgg-default-keyserver-address variable!
 * Do not panic if mails are not sended automatically! Use <kbd>M-m a
   S</kbd> for it!
* Browser
  * A full setup of emacs-w3m.
* Chat
 * A simple ERC setup for using IRC
* Organisation
 * A simple GTD implementation
* Multimedia
 * A full setup for EMMS, including a script to access EMMS without an
   open Emacs frame
 * Includes a setup for the music player demon
* File sharing
 * A simple setup for rtorrent
* You can fully use it without a running X server!
* Daemon setup
 * systemd user level daemon
 * sysvinit daemon shell script for every user
* A keyboard setup similar
  to [Spacemacs](https://github.com/syl20bnr/spacemacs). These means
  keys defined by this configuration start with <kbd>M-m</kbd>.

## Requirements
=======
## Supported Emacs versions

The config should run on Emacs 23.3 or greater and is designed to
degrade smoothly - see the Travis build - but note that Emacs 24 and
above is required for an increasing number of key packages, including
`magit` and `flycheck`, so to get full you should use the latest Emacs
version available to you.

Some Windows users might need to
follow
[these instructions](http://xn--9dbdkw.se/diary/how_to_enable_GnuTLS_for_Emacs_24_on_Windows/index.en.html) to
get TLS (ie. SSL) support included in their Emacs.

## Other requirements

To make the most of the programming language-specific support in this
config, further programs will likely be required, particularly those
that [flycheck](https://github.com/flycheck/flycheck) uses to provide
on-the-fly syntax checking.

## Installation
### General
To install, clone this repo to `~/.emacs.d`, i.e. ensure that the
`init.el` contained in this repo ends up at `~/.emacs.d/init.el`:

``` git clone https://github.com/purcell/emacs.d.git ~/.emacs.d ```

Then change into it and do:
```bash
make
```

To install all features shipped with this repository simply do
afterwards:
```bash
make install
```

If you want to know what features are available use the
`print-targets.sh` script to inform yourself.

Upon starting up Emacs for the first time, further third-party
packages will be automatically downloaded and installed. If you
encounter any errors at that stage, try restarting Emacs, and possibly
running `M-x package-refresh-contents` before doing so.



If you like to use EMMS you have to specify the player you want to
use.
```lisp
; in custom.el place:
(setq emms-player-list '(emms-player-mplayer)) ; if you use mplayer
(setq emms-player-list '(emms-player-mpd)) ; if you use mpd
```

### The daemon
#### systemd user level daemon
Pros:
* Does not need root privileges to install
* Very simple to install

Cons:
* Starts emacs on login - this costs much time
* Needs to be installed for EVERY user

```bash
make install-systemd-user-daemon
systemctl --user enable emacs
systemctl --user start emacs
```

#### sysvinit daemon
Pros:
* Very fast startup (on start not on login)
* Adding a new emacs daemon user is unbeatable simple

Cons:
* Needs root privileges to install
* Not that simple to install
* Does not work if you use an encrypted home folder

```bash
su
export THEUSER="your_non_root_user_name another_user_if_you_want_to" # optional
export THEUSER="or_only_one_user"
make install-sysvinit-daemon
systemctl enable emacs # if you have systemd installed
```


## Uninstallation

To uninstall things that have been installed with this Repository and
are specific for Emacs:

```bash
make uninstall
```

To uninstall everything that have been installed with this Repository:

```bash
make uninstall-all
```

## Important note about `ido`

This config enables `ido-mode` completion in the minibuffer wherever
possible, which might confuse you when trying to open files using
<kbd>C-x C-f</kbd>, e.g. when you want to open a directory to use
`dired` -- if you get stuck, use <kbd>C-f</kbd> to drop into the
regular `find-file` prompt. (You might want to customize the
`ido-show-dot-for-dired` variable if this is an issue for you.)

## Updates

Update the config with `git pull`. You'll probably also want/need to
update the third-party packages regularly too:

<kbd>M-x package-list-packages</kbd>, then <kbd>U</kbd> followed by
<kbd>x</kbd>.

## Adding your own customization

To add your own customization, use <kbd>M-x customize</kbd> and/or
create a file `~/.emacs.d/lisp/init-local.el` which looks like this:

```el ... your code here ...

(provide 'init-local) ```

Alternatively, fork the repo and hack away at the config to make it
your own!

If you need initialisation code which executes earlier in the startup process,
you can also create an `~/.emacs.d/lisp/init-preload-local.el` file.

If you plan to customize things more extensively, you should probably
just fork the repo and hack away at the config to make it your own!

For key bindings look at the `~/.emacs.d/lisp/init-keys.el`! It uses
(Spacemacs)[https://github.com/syl20bnr/spacemacs] like key settings,
which means custom keys start with <kbd>M-m</kbd>

## Similar configs

You might also want to check out `emacs-starter-kit` and `prelude`.

## Support / issues

If you hit any problems, please first ensure that you are using the
latest version of this code, and that you have updated your packages
to the most recent available versions (see "Updates" above). If you
still experience problems, go ahead
and
[file an issue on the github project](https://github.com/ritschmaster/emacs.d).

- Richard Paul Bäck

## Special thanks

Special thanks to Steve Purcel. This config is a fork of
his [Config]((https://github.com/purcell/emacs.d).

<hr>

[free-your-pc.com](http://www.free-your-pc.com/)


<a href="https://gnusocial.de/RichardBaeck">
<img src="https://gnusocial.de/theme/neo-gnu/mobilelogo.png"
     alt="@RichardBaeck@gnusocial.de"
     width="50" height="50"></img>
</a>

<a href="https://twitter.com/RichardBaeck">
<img src="https://upload.wikimedia.org/wikipedia/en/thumb/9/9f/Twitter_bird_logo_2012.svg/1267px-Twitter_bird_logo_2012.svg.png" 
     alt="@RichardBaeck@twitter.com"
     width="50" height="50"></img>
</a>




