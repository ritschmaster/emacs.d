EMACS ?= emacs
EMACS_HOME = .

# Collect data about the used init-system
SYSTEMD_PATH := $(HOME)/.config/systemd/user
SYSTEMD_SCRIPT := deamonscripts/emacs.service
ifeq "$(shell which systemctl)" "/usr/bin/systemctl"
	USING_SYSTEMD = "true"
endif

# Initialize things to use Emacs as a mail client
MAIL_SRC_DIR := mail
DOTGNUS_SRC := $(MAIL_SRC_DIR)/.gnus
DOTGNUS_DEST := $(HOME)/.gnus
DOTGNUS_DEST_EXISTS := $(wildcard $(DOTGNUS_DEST))

OFFLINEIMAPRC_SRC := $(MAIL_SRC_DIR)/.offlineimaprc
OFFLINEIMAPRC_DEST := $(HOME)/.offlineimaprc
OFFLINEIMAPRC_DEST_EXISTS := $(wildcard $(OFFLINEIMAPRC_DEST))

OFFLINEIMAPPY_SRC := $(MAIL_SRC_DIR)/.offlineimap.py
OFFLINEIMAPPY_DEST := $(HOME)/.offlineimap.py
OFFLINEIMAPPY_DEST_EXISTS := $(wildcard $(OFFLINEIMAPPY_DEST))

# Initialize game variables
SCORE_DIR := $(EMACS_HOME)/scores
TETRIS_SCORE_FILE := $(SCORE_DIR)/tetris
SNAKE_SCORE_FILE := $(SCORE_DIR)/snake

all:
# Setup of games
	mkdir -p "$(SCORE_DIR)"
	touch $(TETRIS_SCORE_FILE)
	touch $(SNAKE_SCORE_FILE)

install-daemon:
   ifdef USING_SYSTEMD
	mkdir -p "$(SYSTEMD_PATH)"
	cp "$(SYSTEMD_SCRIPT)" "$(SYSTEMD_PATH)/"
   endif

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


install: install-daemon install-mail

uninstall-daemon:
	rm $(SYSTEMD_PATH)/$(shell echo "$(SYSTEMD_SCRIPT)" | cut -d'/' -f2)

uninstall-mail:
	rm $(DOTGNUS_DEST)

uninstall: uninstall-daemon uninstall-mail

uninstall-all-mail:
	rm $(OFFLINEIMAPRC_DEST)
	rm $(OFFLINEIMAPPY_DEST)

uninstall-all: uninstall uninstall-all-mail
