OS := $(shell uname -s)

DEPENDENCIES_SW := stow git

ifeq ($(OS),Darwin)
	INSTALLER_CMD := brew install
else
	INSTALLER_CMD := sudo apt install
endif

ALL_DIRS := $(wildcard */)
STOW_DIRS := $(ALL_DIRS:/=)

.prerequisites:
	$(INSTALLER_CMD) $(DEPENDENCIES_SW)
	@touch $@

all: .prerequisites
	@echo "Applying stow"
	@stow $(STOW_DIRS) -t ~

update:
	git fetch
	git pull --rebase

clean_all: clean
	@rm -f .prerequisites

clean:
	@echo "Cleaning all stowed directory"
	@stow -D $(STOW_DIRS)
