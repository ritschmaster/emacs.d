EMACS ?= emacs
EMACS_HOME = $(HOME)/.emacs.d

# Collect data about the used init-system
SYSTEMD_COMMAND := systemctl
SYSTEMD_PATH := $(HOME)/.config/systemd/user
SYSTEMD_SCRIPT := deamonscripts/emacs.service

USING_INIT := $(shell { type "$(SYSTEMD_COMMAND)"; } 2>/dev/null | cut -d' ' -f1)

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

# Initialize EMMS variables
EMMS_DIR := $(EMACS_HOME)/emms
EMMS_SCORE_FILE := $(EMMS_DIR)/scores
EMMS_STREAM_BOOKMARKS_FILE := $(EMMS_DIR)/emms-streams
EMMS_HISTORY_FILE := $(EMMS_DIR)/emms-history
EMMS_CACHE_FILE := $(EMMS_DIR)/emms-cache

all: setup-games setup-emms

setup-games:
	mkdir -p "$(SCORE_DIR)"
	touch "$(TETRIS_SCORE_FILE)"
	touch "$(SNAKE_SCORE_FILE)"

setup-emms:
	mkdir -p "$(EMMS_DIR)"
	touch "$(EMMS_SCORE_FILE)"
	touch "$(EMMS_STREAM_BOOKMARKS_FILE)"
	touch "$(EMMS_HISTORY_FILE)"
	touch "$(EMMS_CACHE_FILE)"


clean-games:
	rm -rf "$(SCORE_DIR)"

clean-emms:
	rm -rf "$(EMMS_DIR)"

clean: clean-games


install-daemon:
   ifeq "$(USING_INIT)" "$(SYSTEMD_COMMAND)"
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
