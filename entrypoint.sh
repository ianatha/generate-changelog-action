#!/bin/sh -l
# shellcheck disable=SC2039

git clone --quiet https://$GITHUB_TOKEN@github.com/"$REPO"

if [ "$REPO" = "ScottBrenner/generate-changelog-action" ]; then
  cd generate-changelog-action || exit
fi

if [ "$1" ] && [ "$1" != "package.json" ]; then
  cp "$1" package.json
fi

tag=$(git tag --sort version:refname | tail -n 2 | head -n 1)
changelog=$(generate-changelog -t "$tag" --file -)

changelog="${changelog//'%'/'%25'}"
changelog="${changelog//$'\n'/'%0A'}"
changelog="${changelog//$'\r'/'%0D'}"

echo "$changelog"

echo "::set-output name=changelog::$changelog"
