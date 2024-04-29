
#!/bin/bash

# Define variables (replace with your actual values)
REPO_URL="https://github.com/your_username/your_repository.git"
DEST_DIR="/path/to/destination/directory"
ARCHIVE_FILE="archived_file.tar.gz"
SRC_FILE1="path/to/source/file1.conf"
DEST_FILE1="path/to/destination/file1.conf"
SRC_FILE2="path/to/source/file2.sh"
DEST_FILE2="path/to/destination/file2.sh"
OLD_VALUE="old_value"
NEW_VALUE="new_value"
SERVICE_NAME="your_service_name"

# Check for git binary
if ! command -v git &> /dev/null; then
  echo "Error: git command not found. Please install git."
  exit 1
fi

# Clone repository (skip update if already exists)
if [ ! -d "$DEST_DIR/.git" ]; then
  git clone --depth=1 $REPO_URL $DEST_DIR
else
  echo "Skipping clone: Repository already exists."
fi

# Unarchive file if it exists
if [ -f "$DEST_DIR/$ARCHIVE_FILE" ]; then
  tar -xf "$DEST_DIR/$ARCHIVE_FILE" -C "$DEST_DIR"
fi

# Copy files
cp -p "$SRC_FILE1" "$DEST_FILE1"
cp -p "$SRC_FILE2" "$DEST_FILE2"

# Edit files in place (using sed for simple replacements)
sed -i "s/$OLD_VALUE/$NEW_VALUE/g" "$DEST_FILE1"
sed -i "s/# Comment this line//" "$DEST_FILE2"

# Reload service (if running)
if systemctl status $SERVICE_NAME >/dev/null 2>&1 && [[ $? -eq 0 ]]; then
  systemctl reload $SERVICE_NAME
fi

echo "Tasks completed."


### find and edit GRUB_TIMEOUT
#sudo sed -i 's/GRUB_TIMEOUT=0/GRUB_TIMEOUT=10/' /etc/default/grub
### find and edit GRUB_TIMEOUT_STYLE
#sudo sed -i 's/GRUB_TIMEOUT_STYLE=hidden/#GRUB_TIMEOUT_STYPE=hidden/' /etc/default/grub

