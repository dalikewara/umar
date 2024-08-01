#!/bin/sh

repo_url="https://raw.githubusercontent.com/dalikewara/umar/main"
script_name="umar.sh"
install_dir="/usr/local/bin"
target_name="umar"

echo "Downloading the latest version of $script_name from $repo_url..."
curl -L "$repo_url/$script_name" -o "/tmp/$script_name"

echo "Installing $target_name to $install_dir..."
sudo mv "/tmp/$script_name" "$install_dir/$target_name"

echo "Making $target_name executable..."
sudo chmod +x "$install_dir/$target_name"

if [ -x "$install_dir/$target_name" ]; then
  echo "$target_name installed/upgraded successfully!"
else
  echo "Failed to install/upgrade $target_name"
  exit 1
fi

