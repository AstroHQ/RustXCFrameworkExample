# Rust & XCFramework Example

This example codebase demonstrates using cargo-lipo tool & some scripts to ensure proper universal library building & ability to make an XCFramework out of them as well.

## Reasoning

This might be useful if you're not directly including the library in your main Xcode project, say producing a downloadable binary for others. XCFramework fills the need for this. If you want to build from source, you can also just look at the framework project & mylib/build-platform.sh

## Usage of RustTestApp

1. Don't open the project yet...
2. Run `./make-xcf.sh` to build the RustTest.xcframework
3. Open RustTestApp.xcodeproj
4. Build & run on sim or iOS device

## Todo

- [ ] Implement a macOS framework & test app
- [x] Implement an iOS framework & test app

## Mac Catalyst

I left out Mac Catalyst because that target is fairly immature sounding for Rust. It requires a lot more work to get going.
