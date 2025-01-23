OS := $(shell uname -s)

DISTRO ?= archlinux
DISTRO_VERSION ?= latest

DOCKER_IMAGE_NAME := test_$(DISTRO)_$(DISTRO_VERSION)
DOCKERFILE := docker/Dockerfile.$(DISTRO)

DEPENDENCIES_SW := stow git ansible

TEST_DEPENDENCIES_SW := docker

ALL_DIRS := $(shell ls config)
DOT_CONFIG_DIRS=$(shell ls config/config)

STOW_DOT_CONFIG_DIRS := $(DOT_CONFIG_DIRS:/=)

all: .apply_stow

build_docker: $(DOCKERFILE)
	docker build -t $(DOCKER_IMAGE_NAME) -f $(DOCKERFILE) --build-arg TAG=$(DISTRO_VERSION) --build-arg USER=$(USER) .

run_docker: build_docker
	docker run -it --rm -v $(shell pwd):/home/$(USER)/dotfiles $(DOCKER_IMAGE_NAME)

.apply_stow: $(HOME)/.config
	@echo "Applying stow"
	@echo stow $(STOW_DOT_CONFIG_DIRS) -d config/config -t $(HOME)/.config
	@stow $(STOW_DOT_CONFIG_DIRS) -d config/config -t $(HOME)/.config

$(HOME)/.config:
	@mkdir -p $(HOME)/.config

update:
	git fetch
	git pull --rebase

clean:
	@echo "Cleaning all stowed directory"
	@stow -D $(STOW_DOT_CONFIG_DIRS) -d config/config -t $(HOME)/.config
