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

all: .prerequisites zsh/.zprezto/contrib
	@echo "Applying stow"
	@stow $(STOW_DIRS) -t ~

zsh/.zprezto:
	git clone --recursive https://github.com/sorin-ionescu/prezto.git zsh/.zprezto

zsh/.zprezto/contrib: zsh/.zprezto
	git clone --recurse-submodules https://github.com/belak/prezto-contrib zsh/.zprezto/contrib

update:
	git fetch
	git pull --rebase

clean_all: clean
	@rm -f .prerequisites
	@echo "Cleaning zsh"
	@rm -rf zsh/.zprezto

clean:
	@echo "Cleaning all stowed directory"
	@stow -D $(STOW_DIRS)
