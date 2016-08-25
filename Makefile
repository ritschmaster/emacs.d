EMACS ?= emacs
EMACS_HOME = $(HOME)/.emacs.d
CURRENT_USER = $(shell whoami)
INSTALL_SRC_DIR = $(shell pwd)
SRC_DIR := $(INSTALL_SRC_DIR)/src
LOCAL_EMACS_LIBS_DIR := $(INSTALL_SRC_DIR)/site-lisp

DEST_BIN_DIR := $(HOME)/bin

SYSTEMD_COMMAND := systemctl
SYSTEMD_PATH := $(HOME)/.config/systemd/user

USING_INIT := $(shell { type "$(SYSTEMD_COMMAND)"; } 2>/dev/null | cut -d' ' -f1)

all: setup-games setup-emms

# Collect data about the used init-system
DAEMONSCRIPTS_DIR := $(SRC_DIR)/daemonscripts
SYSTEMD_SCRIPT := $(DAEMONSCRIPTS_DIR)/emacs.service

SYSVINIT_DEST_DIR := /etc/init.d
SYSVINIT_SCRIPT_NAME := emacs

install-systemd-user-daemon:
	mkdir -p "$(SYSTEMD_PATH)"
	cp "$(SYSTEMD_SCRIPT)" "$(SYSTEMD_PATH)/"

uninstall-systemd-user-daemon:
	rm "$(SYSTEMD_PATH)"/$(shell echo "$(SYSTEMD_SCRIPT)" | cut -d'/' -f2)

install-sysvinit-daemon:
	cp $(DAEMONSCRIPTS_DIR)/$(SYSVINIT_SCRIPT_NAME) $(SYSVINIT_DEST_DIR)/$(SYSVINIT_SCRIPT_NAME)
	chmod +x $(SYSVINIT_DEST_DIR)/$(SYSVINIT_SCRIPT_NAME)
	sed -i "s/USERS=\"\"/USERS=\"$(THEUSER)\"/g" $(SYSVINIT_DEST_DIR)/$(SYSVINIT_SCRIPT_NAME)

uninstall-sysvinit-daemon:
	service $(SYSVINIT_SCRIPT_NAME) stop
	rm $(SYSVINIT_DEST_DIR)/$(SYSVINIT_SCRIPT_NAME)

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

ORG_MIME_LINK := http://orgmode.org/w/?p=org-mode.git;a=blob_plain;f=contrib/lisp/org-mime.el;hb=HEAD
ORG_MIME_DEST := $(LOCAL_EMACS_LIBS_DIR)/org-mime.el

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
	wget -O $(ORG_MIME_DEST) $(ORG_MIME_LINK)

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
	mkdir -p "$(EMMS_CACHE_DEST_DIR)"
	touch "$(EMMS_SCORE_FILE)"
	touch "$(EMMS_STREAM_BOOKMARKS_FILE)"
	touch "$(EMMS_HISTORY_FILE)"
	touch "$(EMMS_CACHE_FILE)"
clean-emms:
	rm -rf "$(EMMS_CACHE_DEST_DIR)"

install-emms:
   ifneq "$(EMMS_REMOTE_DEST_EXISTS)" "$(EMMS_REMOTE_DEST)"
	cp "$(EMMS_REMOTE_SRC)" "$(EMMS_REMOTE_DEST)"
   endif

uninstall-emms:
	rm "$(EMMS_REMOTE_DEST)"


# MPD daemon script
MPD_SYSTEMD_SCRIPT_SRC := $(DAEMONSCRIPTS_DIR)/mpd.service
MPD_SYSTEMD_SCRIPT_DEST := $(SYSTEMD_PATH)/mpd.service
MPD_SYSTEMD_SCRIPT_DEST_EXISTS := $(wildcard $(MPD_SYSTEMD_SCRIPT_DEST))

MPD_SRC_DIR := $(SRC_DIR)/mpd
MPD_DEST_DIR := $(HOME)/.config/mpd
MPD_CONF_SRC := $(MPD_SRC_DIR)/mpd.conf
MPD_CONF_DEST := $(MPD_DEST_DIR)/mpd.conf
MPD_CONF_DEST_EXISTS := $(wildcard $(MPD_CONF_DEST))
MPD_CONF_FILES := database log pid state sticker sql

install-mpd:
   ifeq "$(USING_INIT)" "$(SYSTEMD_COMMAND)"
	mkdir -p "$(SYSTEMD_PATH)"
   ifneq "$(MPD_SYSTEMD_SCRIPT_DEST_EXISTS)" "$(MPD_SYSTEMD_SCRIPT_DEST)"
	cp "$(MPD_SYSTEMD_SCRIPT_SRC)" "$(SYSTEMD_PATH)/"
   endif
   endif

	mkdir -p "$(MPD_DEST_DIR)"
	for f in $(MPD_CONF_FILES); do \
		touch "$(MPD_DEST_DIR)/$$f"; \
	done
   ifneq "$(MPD_CONF_DEST_EXISTS)" "$(MPD_CONF_DEST)"
	cp "$(MPD_CONF_SRC)" "$(MPD_CONF_DEST)"
   endif

uninstall-all-mpd:
	rm "$(MPD_SYSTEMD_SCRIPT_DEST)"
	rm "$(MPD_CONF_DEST)"


# Org-Mode
ORG_MODE_SRC_DIR := $(SRC_DIR)/org-mode
ORG_MODE_GTD_SRC := $(ORG_MODE_SRC_DIR)/gtd.org

ORG_MODE_DEST_DIR := $(HOME)/org_mode
ORG_MODE_GTD_DEST := $(ORG_MODE_DEST_DIR)/gtd.org
ORG_MODE_GTD_DEST_EXISTS := $(wildcard $(ORG_MODE_GTD_DEST))
ORG_MODE_NOTES_DEST := $(ORG_MODE_DEST_DIR)/notes.org

install-org-mode:
	mkdir -p "$(ORG_MODE_DEST_DIR)"
   ifneq "$(ORG_MODE_GTD_DEST_EXISTS)" "$(ORG_MODE_GTD_DEST)"
	cp "$(ORG_MODE_GTD_SRC)" "$(ORG_MODE_GTD_DEST)"
   endif
	touch "$(ORG_MODE_NOTES_DEST)"

uninstall-org-mode:

uinstall-all-org-mode: uninstall-org-mode
	rm -r "$(ORG_MODE_DEST_DIR)"


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

uninstall-all-torrent: uninstall-torrent
	rm "$(TORRENT_DEST_RC)"
	rm -r "$(TORRENT_DEST_SESSION_DIR)"

# JDEE
JDEE_SERVER_URL = https://github.com/jdee-emacs/jdee-server/archive/master.zip
JDEE_ZIP_FILE = master.zip
JDEE_ZIP_DIR_ORIG = jdee-server-master
JDEE_ZIP_DIR = jdee-server
install-jdee:
	wget "$(JDEE_SERVER_URL)"
	unzip $(JDEE_ZIP_FILE)
	mv $(JDEE_ZIP_DIR_ORIG) $(JDEE_ZIP_DIR)
	rm -rf "$(JDEE_ZIP_FILE)"
	cd $(JDEE_ZIP_DIR) && mvn assembly:assembly

uninstall-jdee:
	rm -rf "$(JDEE_ZIP_DIR)"

# CLEAN
clean: clean-games

# INSTALL
install: install-mail install-emms install-mpd install-jdee

# UNINSTALL
uninstall: uninstall-daemon uninstall-mail uninstall-emms uninstall-jdee

uninstall-all: uninstall uninstall-all-mail uninstall-all-torrent uninstall-all-mpd
