OS := $(shell uname -s)

DEPENDENCIES_SW := stow git

ifeq ($(OS),Darwin)
	INSTALLER_CMD := brew install
else
	INSTALLER_CMD := sudo apt install
endif

STOW_DIRS := $(foreach dir,$(shell find -mindepth 1 -maxdepth 1 -type d),$(notdir $(dir)))
STOW_DIRS := $(filter-out .git,$(STOW_DIRS))

.prerequisites:
	$(INSTALLER_CMD) $(DEPENDENCIES_SW)
	@touch $@

all: .prerequisites zsh/.zprezto/contrib
	stow $(STOW_DIRS)

bob:
	echo $(STOW_DIRS)

zsh/.zprezto:
	git clone --recursive https://github.com/sorin-ionescu/prezto.git zsh/.zprezto

zsh/.zprezto/contrib: zsh/.zprezto
	git clone --recurse-submodules https://github.com/belak/prezto-contrib zsh/.zprezto/contrib

update:
	git fetch
	git pull --rebase

cleann_all: clean
	@rm -f .prerequisites
	@rm -rf zsh/.zprezto

clean:
	stow -D $(STOW_DIRS)
