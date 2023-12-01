OS := $(shell uname -s)

DISTRO ?= archlinux
DISTRO_VERSION ?= latest

DOCKER_IMAGE_NAME := test_$(DISTRO)_$(DISTRO_VERSION)
DOCKERFILE := docker/Dockerfile.$(DISTRO)

DEPENDENCIES_SW := stow git ansible

TEST_DEPENDENCIES_SW := docker

ANSIBLE_PLAYBOOK_ARGS=

ifeq ($(wildcard /.dockerenv),)
	ANSIBLE_PLAYBOOK_ARGS+="--ask-become-pass"
endif

ifeq ($(OS),Darwin)
	INSTALLER_CMD := brew install
else
	INSTALLER_CMD := echo sudo apt install
endif

ALL_DIRS := $(shell ls config)
STOW_DIRS := $(ALL_DIRS:/=)

all: .run_ansible .apply_stow

.prerequisites:
	$(INSTALLER_CMD) $(DEPENDENCIES_SW)
	@touch $@

.test_prerequisites:
	$(INSTALLER_CMD) $(TEST_DEPENDENCIES_SW)
	@touch $@

build_docker: $(DOCKERFILE)
	docker build -t $(DOCKER_IMAGE_NAME) -f $(DOCKERFILE) --build-arg TAG=$(DISTRO_VERSION) --build-arg USER=$(USER) .

run_docker: build_docker
	docker run -it --rm -v $(shell pwd):/home/$(USER)/dotfiles $(DOCKER_IMAGE_NAME)

.run_ansible:
	cd ansible; ansible-galaxy collection install -r requirements.yml
	cd ansible; ansible-playbook $(ANSIBLE_PLAYBOOK_ARGS) ./bootstrap.yml

	rm -f ~/.zshenv

.apply_stow:
	@echo "Applying stow"
	@stow $(STOW_DIRS) -d config -t ~

update:
	git fetch
	git pull --rebase

clean_all: clean
	@rm -f .prerequisites

clean:
	@echo "Cleaning all stowed directory"
	@stow -D $(STOW_DIRS) -d config -t ~
