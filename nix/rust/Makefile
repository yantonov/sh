help:
	@cat Makefile

BIN_DIR="$(HOME)/bin"
SOURCE_DIR="$(HOME)/Development/bin"

EXECUTABLE_NAME?="$(APP_NAME)"

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
		mkdir -p "$(SOURCE_DIR)" && \
		cd "$(SOURCE_DIR)" && \
		if [ -d "$(APP_NAME)" ]; then \
			echo "$(APP_NAME) directory is already exist inside $(SOURCE_DIR)"; \
		exit 1; \
		fi && \
		git clone "$(URL)" "$(APP_NAME)" && \
		cd "$(APP_NAME)" && \
		cargo build --release
	@echo "Build is successfully completed!"

install:
	@echo "Install..." \
		mkdir -p "$(BIN_DIR)" && \
		cd "$(SOURCE_DIR)" && \
		rm "$(BIN_DIR)/$(EXECUTABLE_NAME)" && \
		cp "$(APP_NAME)/target/release/$(EXECUTABLE_NAME)" "$(BIN_DIR)/$(EXECUTABLE_NAME)" && \
		rm -rf "$(APP_NAME)"
	@echo "Installation is successfully completed!"
