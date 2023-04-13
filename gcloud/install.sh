# Establish the bucket
BUCKET='cloud-sdk-release'

# Fetch latest release archive name
LATEST_OBJ_NAME="$(curl --silent "https://storage.googleapis.com/storage/v1/b/$BUCKET/o?delimiter=/&matchGlob=google-cloud-cli*darwin-arm*" | jq '.items | last.name' | cut -f 2 -d \")"

# Determine archive filepath
ARCHIVE_FILE="$GCLOUD_DATA_DIR/$LATEST_OBJ_NAME"

# Ensure the archive directory exists
mkdir -p "$GCLOUD_DATA_DIR"

# Download the archive to its filepath
curl --output "$ARCHIVE_FILE" "https://storage.googleapis.com/storage/v1/b/$BUCKET/o/$LATEST_OBJ_NAME?alt=media"

# Extract the archive. This creates a sibling folder `google-cloud-sdk`, which the `rc.sh` references
tar --extract --file "$ARCHIVE_FILE" --directory "$GCLOUD_DATA_DIR"

# Clean up by removing the archive
rm "$ARCHIVE_FILE"
