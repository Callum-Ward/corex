#!/bin/bash
# Builds the ORE binaries inside a Docker container and extracts the resulting
# tarball (corex-bin-8-linux-x86_64.tar.gz) to the current directory.
#
# The build layers (Boost + ORE compilation) are cached by Docker after the
# first run - subsequent runs are near-instant.
#
# Prerequisites: Docker must be installed and running.
# Once complete, corex-bin-8-linux-x86_64.tar.gz will be in this directory,
# ready to be used with: docker build -t corex .

set -e

echo "Building ORE builder image (Boost + ORE compilation)..."
docker build -f Dockerfile.build -t corex-builder .

echo "Extracting tarball..."
docker run --rm -v "$(pwd):/output" corex-builder

echo "Done. corex-bin-8-linux-x86_64.tar.gz is ready."
echo "You can now build the benchmark image with: docker build -t corex ."
