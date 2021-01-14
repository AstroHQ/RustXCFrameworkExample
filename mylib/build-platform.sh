#!/bin/sh
LIBNAME="mylib"

# Just in case since if run from Xcode, Xcode won't by default pick up your shell's various config like PATH setting
PATH=$PATH:~/.cargo/bin

# Platform to build universal for, defaults to 'all'
PLATFORM=${1:-all}
CONFIGURATION=${CONFIGURATION:-Release}
CARGO_ARGS=()
RUST_CONFIG="debug"
if [[ $CONFIGURATION == "Release" ]]; then
    CARGO_ARGS+=("--release")
    RUST_CONFIG="release"
fi

cargo_lipo() {
    CARGO_ARCHS=$1
    CARGO_PLATFORM=$2
    cargo lipo ${CARGO_ARGS[*]} --targets "$CARGO_ARCHS"
    mkdir -p "target/universal-${CARGO_PLATFORM}/$RUST_CONFIG/"
    mv "target/universal/$RUST_CONFIG/lib${LIBNAME}.a" "target/universal-${CARGO_PLATFORM}/${RUST_CONFIG}/"
    rm -rf "target/universal/"
}
build_mac() {
    echo "Building for macOS in $CONFIGURATION config"
    cargo_lipo "aarch64-apple-darwin,x86_64-apple-darwin" "apple-darwin"
}
build_ios() {
    echo "Building for iOS in $CONFIGURATION config"
    cargo_lipo "aarch64-apple-ios,x86_64-apple-ios" "apple-ios"
}

case $PLATFORM in
  "mac")
    build_mac
    ;;
  "ios")
    build_ios
    ;;
    # catalyst requires a lot of work since it's not in rust stable yet
#   "catalyst")
#     echo "Mac Catalyst"
#     ;;
  "all")
    build_mac
    build_ios
    ;;
  *)
    echo "Unsupproted platform: $PLATFORM"
    exit 1
    ;;
esac
