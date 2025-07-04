#!/bin/sh

mkdir -p export/macOS
mkdir -p export/macOS-demo

cd godot
godot --headless --export-debug macOS "../export/macos/Godot Export Test.app" --quit
godot --headless --export-debug macOS-demo "../export/macos-demo/Godot Export Test - Demo.app" --quit

