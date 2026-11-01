help:
	@cat Makefile

BIN_DIR?=$(HOME)/.local/bin
CLONE_DIR?=$(HOME)/Development/bin

EXECUTABLE_NAME?=$(APP_NAME)

build:
	if [ -z "$(APP_NAME)" ]; then \
		echo "APP_NAME is undefined"; \
		exit 1; \
	fi
	if [ -z "$(URL)" ]; then \
		echo "URL is undefined"; \
		exit 1; \
	fi
    # think about moving all of this to separate script
    # right now it is here because it is no needed to increase the number of files
    # and changes to this snippets are supposed to be rare

    # prerequisites for ubuntu
    # apt-get install libclang-dev
	@echo "Build..." && \
		mkdir -p "$(CLONE_DIR)" && \
		if [ -d "$(CLONE_DIR)/$(APP_NAME)/.git" ]; then \
			cd "$(CLONE_DIR)/$(APP_NAME)" && ( git pull --ff-only || ( cd .. && rm -rf "$(APP_NAME)" && git clone "$(URL)" "$(APP_NAME)" && cd "$(APP_NAME)" ) ); \
		else \
			rm -rf "$(CLONE_DIR)/$(APP_NAME)" && \
			git clone "$(URL)" "$(CLONE_DIR)/$(APP_NAME)" && \
			cd "$(CLONE_DIR)/$(APP_NAME)"; \
		fi && \
		cargo build --release
	@echo "Build is successfully completed!"

install:
	@echo "Install to $(BIN_DIR)..." && \
		mkdir -p "$(BIN_DIR)" && \
		cd "$(CLONE_DIR)" && \
		rm -f "$(BIN_DIR)/$(EXECUTABLE_NAME)" && \
		cp "$(APP_NAME)/target/release/$(EXECUTABLE_NAME)" "$(BIN_DIR)/$(EXECUTABLE_NAME)"
	@echo "Installation is successfully completed!"
