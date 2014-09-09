EMACS ?= emacs

SYSTEMD_PATH := $(HOME)/.config/systemd/user
SYSTEMD_SCRIPT := deamonscripts/emacs.service
ifeq "$(shell which systemctl)" "/usr/bin/systemctl"
	USING_SYSTEMD = "true"
endif

# Things to use Emacs as a mail client
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

all:

install:
   ifdef USING_SYSTEMD
	mkdir -p "$(SYSTEMD_PATH)"
	cp "$(SYSTEMD_SCRIPT)" "$(SYSTEMD_PATH)/"
   endif
   ifneq "$(DOTGNUS_DEST_EXISTS)" "$(DOTGNUS_DEST)"
	cp "$(DOTGNUS_SRC)" "$(DOTGNUS_DEST)"
   endif
   ifneq "$(OFFLINEIMAPRC_DEST_EXISTS)" "$(OFFLINEIMAPRC_DEST)"
	cp "$(OFFLINEIMAPRC_SRC)" "$(OFFLINEIMAPRC_DEST)"
   endif
   ifneq "$(OFFLINEIMAPPY_DEST_EXISTS)" "$(OFFLINEIMAPPY_DEST)"
	cp "$(OFFLINEIMAPPY_SRC)" "$(OFFLINEIMAPPY_DEST)"
   endif


uninstall:
	rm $(SYSTEMD_PATH)/$(shell echo "$(SYSTEMD_SCRIPT)" | cut -d'/' -f2)
	rm $(DOTGNUS_DEST)

uninstall-full: uninstall
	rm $(OFFLINEIMAPRC_DEST)
	rm $(OFFLINEIMAPPY_DEST)
