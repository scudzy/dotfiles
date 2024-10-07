#!/bin/bash

# Script to archive browser user profiles and optionally delete the original folder.

# Function to display usage
usage() {
  echo "Usage: $0 [profile_path]"
  echo "Example: $0 /home/user/.mozilla/firefox"
  exit 1
}

# Check if the correct number of arguments is passed
if [ "$#" -ne 1 ]; then
  usage
fi

PROFILE_PATH=$1  # Path to the browser profile directory

# Check if the profile directory exists
if [ ! -d "$PROFILE_PATH" ]; then
  echo "Error: Directory $PROFILE_PATH does not exist."
  exit 1
fi

# Get current date and time in the format YYYYMMDD_HHMMSS
CURRENT_DATE=$(date +"%d-%m-%Y_%H%M")

# Create the archive name using the profile folder name and the current date
ARCHIVE_NAME="backup_$CURRENT_DATE"

# Create the archive with verbose output, exclude unnecessary files
echo "Creating archive $ARCHIVE_NAME.tar.xz from $PROFILE_PATH..."
tar -cvJf "$ARCHIVE_NAME.tar.xz" --exclude='*.tmp' --exclude='*.dmp' --exclude='Code Cache' "$PROFILE_PATH"

# Check if the tar command was successful
if [ $? -eq 0 ]; then
  echo "Archive $ARCHIVE_NAME.tar.xz created successfully."
else
  echo "Error: Failed to create the archive."
  exit 1
fi

# Prompt the user to delete the original folder
read -p "Do you want to delete the original profile folder $PROFILE_PATH? [y/N]: " DELETE_CONFIRMATION

if [[ "$DELETE_CONFIRMATION" =~ ^[Yy]$ ]]; then
  echo "Deleting folder $PROFILE_PATH..."
  rm -rf "$PROFILE_PATH"

  # Check if the deletion was successful
  if [ $? -eq 0 ]; then
    echo "Folder $PROFILE_PATH deleted successfully."
  else
    echo "Error: Failed to delete $PROFILE_PATH."
    exit 1
  fi
else
  echo "Folder $PROFILE_PATH was not deleted."
fi

echo "Backup process completed."
