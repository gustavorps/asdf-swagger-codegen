#!/usr/bin/env bash

# asdf env vars:
# ASDF_INSTALL_TYPE : version or ref
# ASDF_INSTALL_VERSION : full version number or git ref
# ASDF_INSTALL_PATH : where the tool should be
# ASDF_CONCURRENCY : number of cores
# ASDF_DOWNLOAD_PATH : where bin/download downloads to
# ASDF_PLUGIN_PATH : where the plugin is installed
# ASDF_PLUGIN_SOURCE_URL : url of the plugin
# ASDF_PLUGIN_PREV_REF : previous git-ref of plugin
# ASDF_PLUGIN_POST_REF : updated git-ref of plugin
# ASDF_CMD_FILE : full path of file being sourced

set -euo pipefail

GH_REPO="https://github.com/swagger-api/swagger-codegen"
TOOL_NAME="swagger-codegen"
TOOL_TEST="swagger-codegen version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags |
		grep -E '^[0-9]+\.[0-9]+\.[0-9]+$'
}

maven_url() {
	local version="$1"
	if [[ "$version" =~ ^3\. ]]; then
		echo "https://repo1.maven.org/maven2/io/swagger/codegen/v3/swagger-codegen-cli/${version}/swagger-codegen-cli-${version}.jar"
	else
		echo "https://repo1.maven.org/maven2/io/swagger/swagger-codegen-cli/${version}/swagger-codegen-cli-${version}.jar"
	fi
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$(maven_url "$version")"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="$3"

	if ! command -v java >/dev/null; then
		echo "You need a Java Runtime already installed on your computer."
		echo "Follow the instructions for your platform or download it"
		echo "from http://java.com/en/download"
		exit 1
	fi

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	local jar_file="$install_path/swagger-codegen-cli-$version.jar"
	local script_file="$install_path/bin/$TOOL_NAME"

	if ! {
		mkdir -p "$install_path/bin" &&
			cp "$ASDF_DOWNLOAD_PATH/swagger-codegen-cli-$version.jar" "$jar_file" &&
			cat >"$script_file" <<-EOF
				#!/usr/bin/env bash
				set -euo pipefail
				exec java \${JAVA_OPTS:-} -jar "$jar_file" "\$@"
			EOF
		chmod +x "$script_file"
	}; then
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	fi

	local tool_cmd
	tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
	if ! test -x "$install_path/bin/$tool_cmd"; then
		rm -rf "$install_path"
		fail "Expected $install_path/bin/$tool_cmd to be executable."
	fi

	echo "$TOOL_NAME $version installation was successful!"
}
