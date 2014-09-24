EMACS ?= emacs
EMACS_HOME = $(HOME)/.emacs.d
CURRENT_USER = $(shell whoami)
INSTALL_SRC_DIR = $(shell pwd)
SRC_DIR := $(INSTALL_SRC_DIR)/src

DEST_BIN_DIR := $(HOME)/bin

SYSTEMD_COMMAND := systemctl
SYSTEMD_PATH := $(HOME)/.config/systemd/user

USING_INIT := $(shell { type "$(SYSTEMD_COMMAND)"; } 2>/dev/null | cut -d' ' -f1)

all: setup-games setup-emms

# Collect data about the used init-system
DAEMONSCRIPTS_DIR := $(SRC_DIR)/daemonscripts
SYSTEMD_SCRIPT := $(DAEMONSCRIPTS_DIR)/emacs.service

install-daemon:
   ifeq "$(USING_INIT)" "$(SYSTEMD_COMMAND)"
	mkdir -p "$(SYSTEMD_PATH)"
	cp "$(SYSTEMD_SCRIPT)" "$(SYSTEMD_PATH)/"
   endif

uninstall-daemon:
	rm "$(SYSTEMD_PATH)"/$(shell echo "$(SYSTEMD_SCRIPT)" | cut -d'/' -f2)


# MAIL
MAIL_SRC_DIR := $(SRC_DIR)/mail
DOTGNUS_SRC := $(MAIL_SRC_DIR)/.gnus
DOTGNUS_DEST := $(HOME)/.gnus
DOTGNUS_DEST_EXISTS := $(wildcard $(DOTGNUS_DEST))

OFFLINEIMAPRC_SRC := $(MAIL_SRC_DIR)/.offlineimaprc
OFFLINEIMAPRC_DEST := $(HOME)/.offlineimaprc
OFFLINEIMAPRC_DEST_EXISTS := $(wildcard $(OFFLINEIMAPRC_DEST))

OFFLINEIMAPPY_SRC := $(MAIL_SRC_DIR)/.offlineimap.py
OFFLINEIMAPPY_DEST := $(HOME)/.offlineimap.py
OFFLINEIMAPPY_DEST_EXISTS := $(wildcard $(OFFLINEIMAPPY_DEST))

install-mail:
   ifneq "$(DOTGNUS_DEST_EXISTS)" "$(DOTGNUS_DEST)"
	cp "$(DOTGNUS_SRC)" "$(DOTGNUS_DEST)"
   endif
   ifneq "$(OFFLINEIMAPRC_DEST_EXISTS)" "$(OFFLINEIMAPRC_DEST)"
	cp "$(OFFLINEIMAPRC_SRC)" "$(OFFLINEIMAPRC_DEST)"
   endif
   ifneq "$(OFFLINEIMAPPY_DEST_EXISTS)" "$(OFFLINEIMAPPY_DEST)"
	cp "$(OFFLINEIMAPPY_SRC)" "$(OFFLINEIMAPPY_DEST)"
   endif

uninstall-mail:
	rm "$(DOTGNUS_DEST)"

uninstall-all-mail:
	rm $(OFFLINEIMAPRC_DEST)
	rm $(OFFLINEIMAPPY_DEST)


# Initialize game variables
SCORE_DIR := $(EMACS_HOME)/scores
TETRIS_SCORE_FILE := $(SCORE_DIR)/tetris
SNAKE_SCORE_FILE := $(SCORE_DIR)/snake

setup-games:
	mkdir -p "$(SCORE_DIR)"
	touch "$(TETRIS_SCORE_FILE)"
	touch "$(SNAKE_SCORE_FILE)"

clean-games:
	rm -rf "$(SCORE_DIR)"


# EMMS
EMMS_SRC_DIR := $(SRC_DIR)/emms
EMMS_CACHE_DEST_DIR := $(EMACS_HOME)/emms

EMMS_SCORE_FILE := $(EMMS_CACHE_DEST_DIR)/scores
EMMS_STREAM_BOOKMARKS_FILE := $(EMMS_CACHE_DEST_DIR)/emms-streams
EMMS_HISTORY_FILE := $(EMMS_CACHE_DEST_DIR)/emms-history
EMMS_CACHE_FILE := $(EMMS_CACHE_DEST_DIR)/emms-cache

EMMS_REMOTE_SRC := $(EMMS_SRC_DIR)/emms-remote
EMMS_REMOTE_DEST := $(DEST_BIN_DIR)/emms-remote
EMMS_REMOTE_DEST_EXISTS := $(wildcard $(EMMS_REMOTE_DEST))

setup-emms:
	mkdir -p "$(EMMS_DIR)"
	touch "$(EMMS_SCORE_FILE)"
	touch "$(EMMS_STREAM_BOOKMARKS_FILE)"
	touch "$(EMMS_HISTORY_FILE)"
	touch "$(EMMS_CACHE_FILE)"
clean-emms:
	rm -rf "$(EMMS_DIR)"

install-emms:
   ifneq "$(EMMS_REMOTE_DEST_EXISTS)" "$(EMMS_REMOTE_DEST)"
	cp "$(EMMS_REMOTE_SRC)" "$(EMMS_REMOTE_DEST)"
   endif

uninstall-emms:
	rm "$(EMMS_REMOTE_DEST)"

# TORRENT
TORRENT_SRC_DIR := $(SRC_DIR)/torrent
TORRENT_SRC_RC := $(TORRENT_SRC_DIR)/rtorrent.rc
TORRENT_SRC_SYSTEMD_SCRIPT := $(TORRENT_SRC_DIR)/rtorrent.service

TORRENT_DEST_DIR := $(HOME)
TORRENT_DEST_SESSION_DIR := $(TORRENT_DEST_DIR)/.rtorrent-session
TORRENT_DEST_TORRENT_DIR := $(TORRENT_DEST_DIR)/torrents
TORRENT_DEST_RC := $(TORRENT_DEST_DIR)/.rtorrent.rc
TORRENT_DEST_RC_EXISTS := $(wildcard $(TORRENT_DEST_RC))

install-torrent:
   ifeq "$(USING_INIT)" "$(SYSTEMD_COMMAND)"
	cp "$(TORRENT_SRC_SYSTEMD_SCRIPT)" "$(SYSTEMD_PATH)"/
   endif

   # ifneq "$(TORRENT_DEST_RC_EXISTS)" "$(TORRENT_DEST_RC)"
	sed "s/\[user\]/$(CURRENT_USER)/g" <"$(TORRENT_SRC_RC)" >"$(TORRENT_DEST_RC)"
   # endif
	mkdir -p "$(TORRENT_DEST_SESSION_DIR)"
	mkdir -p "$(TORRENT_DEST_TORRENT_DIR)"

uninstall-torrent:

Uninstall-all-torrent: uninstall-torrent
	rm "$(TORRENT_DEST_RC)"
	rm -r "$(TORRENT_DEST_SESSION_DIR)"


# CLEAN
clean: clean-games

# INSTALL
install: install-daemon install-mail install-emms

# UNINSTALL
uninstall: uninstall-daemon uninstall-mail uninstall-emms

uninstall-all: uninstall uninstall-all-mail uninstall-all-torrent
