#!/bin/bash

set -e

# Define variables
LAMBDA_SRC_DIR_PATH="$LAMBDA_SRC_DIR_PATH"
DIST_DIR="dist"

# Navigate to the root directory
rm -rf "$LAMBDA_SRC_DIR_PATH/$DIST_DIR"
rm -rf "$LAMBDA_SRC_DIR_PATH/node_modules"
rm -rf "$LAMBDA_SRC_DIR_PATH/package.json"
rm -rf "$LAMBDA_SRC_DIR_PATH/package-lock.json"

echo "Cleanup completed."
