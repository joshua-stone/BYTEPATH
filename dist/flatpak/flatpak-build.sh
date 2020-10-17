#!/usr/bin/bash

set -oeu pipefail

readonly APP="com.github.bytepath"
readonly APP_BUNDLE="${APP}-x86_64.flatpak"
readonly BUILDDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak-builder --user \
	       --install-deps-from=flathub \
	       --force-clean \
	       --state-dir="${BUILDDIR}/.flatpak-builder" \
	       "${BUILDDIR}/_build" \
	       --repo="${BUILDDIR}/_repo" \
	       "${BUILDDIR}/${APP}.yml"

flatpak build-bundle \
	--arch=x86_64 \
	"${BUILDDIR}/_repo" \
	"${BUILDDIR}/${APP_BUNDLE}" \
        "${APP}" \
        stable
