#!/bin/sh
# Downloads the SDL3 sources into Android/_deps; Gradle builds SDL3 as a shared
# library together with the demo and takes SDL's Java activity from there
set -eu

cd "$(dirname "$0")"
SDL_VERSION=$(sed -n 's/^sdlVersion=//p' gradle.properties)
DEPS="$(pwd)/_deps"
SRC="$DEPS/SDL3-$SDL_VERSION"

mkdir -p "$DEPS"

if [ ! -d "$SRC" ]; then
    curl -fL -o "$DEPS/SDL3-$SDL_VERSION.tar.gz" \
        "https://github.com/libsdl-org/SDL/releases/download/release-$SDL_VERSION/SDL3-$SDL_VERSION.tar.gz"
    tar -xzf "$DEPS/SDL3-$SDL_VERSION.tar.gz" -C "$DEPS"
fi
