#!/bin/bash

# Define dotfile paths as an array
dotfile_paths=(
              "/home/scudzy/.dotfiles/zsh/.zshrc"
              "/home/scudzy/.dotfiles/zsh/.zshenv"
              "/home/scudzy/.dotfiles/zsh/.zprofile"
              "/home/scudzy/.dotfiles/.vimrc"
              "/home/scudzy/.dotfiles/.gitconfig"
              "/home/scudzy/.dotfiles/.gitconfig.user"
)

# Define target directory
target_dir="/home/scudzy"

# Loop through dotfile paths
for dotfile_path in "${dotfile_paths[@]}"; do
  # Extract filename from path
  filename="${dotfile_path##*/}"

  # Check if target file exists
  target_path="$target_dir/$filename"
  if [[ -f "$target_path" ]]; then
    echo "Found existing '$filename' at '$target_path'"

    # Create timestamped backup
    backup_name="$target_path.bak"
    mv "$target_path" "$backup_name"
    echo "Backed up existing '$filename' to '$backup_name'"

    # Check and remove broken symlink backup
    if [[ -L "$backup_name" ]]; then
      echo "Removing broken symlink '$backup_name'"
      rm "$backup_name"
    fi
  else
    echo "Target file '$filename' not found, creating symlink..."
  fi

  # Create symlink
  ln -sf "$dotfile_path" "$target_path"
  echo "Linked '$dotfile_path' to '$target_path'"
done

echo "Done!"
