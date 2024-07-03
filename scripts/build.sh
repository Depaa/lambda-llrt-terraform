#!/bin/bash

set -e

# Define variables
LAMBDA_SRC_DIR_PATH="$LAMBDA_SRC_DIR_PATH"
CACHE_DIR=".tmp"
BINARY_NAME="bootstrap"
BINARY_URL="$BINARY_URL"
DIST_DIR="dist"

# Navigate to the root directory
ROOT_DIR="$(pwd)"

# Check if the Lambda source directory exists
if [ ! -d "$LAMBDA_SRC_DIR_PATH" ]; then
    echo "Error: Lambda source directory $LAMBDA_SRC_DIR_PATH does not exist."
    exit 1
fi

# Check if package.json exists in the root directory, if it does, intall dependencies
if [ ! -f "package.json" ]; then
    echo "Error: package.json not found in the root directory."
    exit 1
fi

# Check if package-lock.json exists before copying
if [ -f "package-lock.json" ]; then
    cp "package-lock.json" "$LAMBDA_SRC_DIR_PATH/"
    cp "package-lock.json" "src/"

else
    echo "Warning: package-lock.json not found."
fi

# Check if package.json exists before copying
if [ -f "package.json" ]; then
    cp "package.json" "$LAMBDA_SRC_DIR_PATH/"
    cp "package.json" "src/"
else
    echo "Warning: package.json not found."
fi

# Check if node_modules have already been created, if not, install them
if [ ! -d "./src/node_modules/" ]; then
    cd "src"
    echo '### INSTALLING NODE MODULES ###'
    npm install --production
    cd ..
else
    echo 'Node modules already installed.'
fi

# Copy the node_modules directory to the Lambda source directory
cp -r "src/node_modules" "$LAMBDA_SRC_DIR_PATH" || true

rm src/package.json
rm src/package-lock.json

# Download and cache the binary
if [ ! -e "${CACHE_DIR}/${BINARY_NAME}" ]; then
    mkdir -p "$CACHE_DIR"
    cd "$CACHE_DIR"

    echo "Downloading binary from $BINARY_URL"
    curl -L -o "llrt_temp.zip" "$BINARY_URL"
    unzip "llrt_temp.zip"
    rm -rf "llrt_temp.zip"
    cd ..
    echo "Binary downloaded and extracted to $CACHE_DIR"
else
    echo "Binary already cached in $CACHE_DIR"
fi

mkdir -p "$LAMBDA_SRC_DIR_PATH/$DIST_DIR"

# Copy the binary to the Lambda source directory
cp "$CACHE_DIR/$BINARY_NAME" "$LAMBDA_SRC_DIR_PATH/$DIST_DIR/"

INPUT_FILE=$LAMBDA_SRC_DIR_PATH/handler.js
OUTPUT_FILE=$LAMBDA_SRC_DIR_PATH/$DIST_DIR/index.mjs

INPUT_FILE=$INPUT_FILE OUTPUT_FILE=$OUTPUT_FILE npm run esbuild

echo "Build completed. The package is located in the $LAMBDA_SRC_DIR_PATH directory."
