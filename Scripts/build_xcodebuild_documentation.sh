#!/bin/bash

docs_dir="docs-out"
branch="main"
tag_pattern="\d+.\d+.\d+"
head_tags=6

usage() {
    echo "This script generates and handles documentation for a specific Swift package."
    echo "Removes old documentation, checks out specific versions, and generates new documentation."
    echo ""
    echo "Usage: ./build_spm_documentation.sh <options>"
    echo ""
    echo "Options:"
    echo " -d <string>     Specify the directory where the documentation will be stored. (default: $docs_dir)"
    echo " -b <string>     Branch from which the documentation will generate. (default: $branch)"
    echo " -t <regex>      Regular expression used to identify tags. (default: $tag_pattern)"
    echo " -c <int>        Keep documentation for the most recent tags. Older versions will be deleted. (default: $head_tags)"
    echo " -s <string>     Xcode scheme for which the documentation should be generated."
    echo ""
    echo "Please provide a command with options when running this script."
    exit 1
}

if [[ $# -eq 0 ]]; then
    usage
fi

while getopts ":d:b:t:c:s:" opt; do
    case $opt in
    d) docs_dir="$OPTARG" ;;
    b) branch="$OPTARG" ;;
    t) tag_pattern="$OPTARG" ;;
    c) head_tags="$OPTARG" ;;
    s) scheme="$OPTARG" ;;
    \?) usage ;;
    esac
done

###

rm -rf "$docs_dir/.git"
rm -rf "$docs_dir/$branch:?"

git tag -l --sort=-v:refname | grep -E "$tag_pattern" | tail -n +"$head_tags" | xargs -I {} rm -rf {}

for tag in $(
    echo "$branch"
    git tag -l --sort=-v:refname | grep -E "$tag_pattern" | head -"$head_tags"
); do
    if [ -d "$docs_dir/$tag/data/documentation/$package_name" ]; then
        echo "✅ Documentation for $tag already exists."
    else
        echo "⏳ Generating documentation for $package_name @ $tag release."
        rm -rf "$docs_dir/$tag:?"

        git checkout .
        git checkout "$tag"

        xcodebuild docbuild \
            -scheme "$scheme" \
            -destination generic/platform=iOS \
            OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path $package_name"/"$tag --output-path $docs_dir/$tag" &&
            echo "✅ Documentation generated for $package_name @ $tag release." ||
            echo "⚠️ Documentation skipped for $package_name @ $tag."
    fi
done
