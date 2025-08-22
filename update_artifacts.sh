#!/bin/bash

# Base URLs and components
COMPONENTS=("minio" "mc" "minkms")
BASE_URL="https://dl.min.io/aistor/%s/release/%s/"
PLATFORMS_minio=("darwin-arm64" "darwin-amd64" "linux-arm64" "linux-amd64")
PLATFORMS_mc=("darwin-arm64" "darwin-amd64" "linux-arm64" "linux-amd64")
PLATFORMS_minkms=("linux-arm64" "linux-amd64") # FIXME: No darwin-* for minkms

# Repository path is the current working directory
REPO_PATH="."

# Ensure required tools are available
command -v curl >/dev/null 2>&1 || {
	echo "curl is required but not installed."
	exit 1
}

# Function to fetch the latest release tag
fetch_latest_release() {
	local component=$1
	local platform=$2
	local url=$(printf "$BASE_URL" "$component" "$platform")
	# Fetch directory listing and extract RELEASE.*Z tags from *.sha256sum files
	local releases
	releases=$(curl -s "$url" | grep -o "${component}\\.RELEASE\\.[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}T[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\}Z\\.sha256sum" | sed "s/${component}\\.\\(.*\\)\\.sha256sum/\\1/" | sort -r)
	# Return the latest release
	echo "$releases" | head -n 1
}

# Function to fetch SHA256 checksum from *.sha256sum file
fetch_sha256() {
	local component=$1
	local platform=$2
	local version=$3
	local url=$(printf "$BASE_URL" "$component" "$platform")"${component}.${version}.sha256sum"
	local checksum
	checksum=$(curl -s -f "$url" | grep -o '^[0-9a-f]\{64\}' | tr -d '\n')
	if [ -n "$checksum" ]; then
		echo "Fetched checksum for $component/$platform: $checksum" >&2
		echo "$checksum"
	else
		echo "Failed to fetch checksum for $component/$platform at $url" >&2
		echo ""
	fi
}

# Function to update formula file
update_formula() {
	local component=$1
	local new_version=$2
	shift 2
	local checksums=("$@")
	local formula_file="$REPO_PATH/${component}.rb"

	if [ ! -f "$formula_file" ]; then
		echo "Formula file $formula_file not found" >&2
		return 1
	fi

	# Backup the original file
	cp "$formula_file" "${formula_file}.bak"

	# Update git_tag and version
	sed -i "s/git_tag = \"RELEASE\.[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}T[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\}Z\"/git_tag = \"${new_version}\"/" "$formula_file"
	sed -i "s/version \"[^\"]*\"/version \"${new_version}\"/" "$formula_file"

	# Update SHA256 checksums for each platform
	local i
	for ((i = 0; i < ${#checksums[@]}; i += 2)); do
		local platform=${checksums[i]}
		local checksum=${checksums[i + 1]}
		if [ -n "$checksum" ] && [ "$checksum" != "Failed to fetch checksum for"* ]; then
			# Escape platform for regex
			local escaped_platform=${platform//-/\\-}
			# Update sha256 line following the url line for this platform
			if grep -q "url .*${escaped_platform}" "$formula_file"; then
				sed -i "/url .*${escaped_platform}/{n;s/sha256 \".*\"/sha256 \"${checksum}\"/}" "$formula_file"
				echo "Updated sha256 for $component/$platform to $checksum"
			else
				echo "Warning: No url line found for $component/$platform in $formula_file" >&2
			fi
		fi
	done

	# Verify changes
	if diff "${formula_file}.bak" "$formula_file" >/dev/null; then
		echo "No changes made to $formula_file"
		rm "${formula_file}.bak"
		return 1
	else
		echo "Updated $formula_file with version $new_version and new SHA256 checksums"
		rm "${formula_file}.bak"
		return 0
	fi
}

# Main automation logic
update_formulas() {
	for component in "${COMPONENTS[@]}"; do
		# Fetch the latest release tag (use linux-amd64 as reference)
		local new_version
		new_version=$(fetch_latest_release "$component" "linux-amd64")
		if [ -z "$new_version" ]; then
			echo "Skipping $component: No release found" >&2
			continue
		fi
		echo "Latest version for $component: $new_version"

		# Fetch checksums for each platform
		declare -a checksums=()
		local platform_var="PLATFORMS_${component}[@]"
		for platform in "${!platform_var}"; do
			local checksum
			checksum=$(fetch_sha256 "$component" "$platform" "$new_version")
			if [ -n "$checksum" ] && [ "$checksum" != "Failed to fetch checksum for"* ]; then
				checksums+=("$platform" "$checksum")
			else
				echo "Skipping $component/$platform due to missing checksum" >&2
			fi
		done

		# Update formula file
		update_formula "$component" "$new_version" "${checksums[@]}"
	done
}

# Execute the script
update_formulas
