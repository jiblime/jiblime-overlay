# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod linux-info

MY_PV=2.2.0-3arter97
MY_P=${PN}-${MY_PV}

DESCRIPTION="exFAT filesystem module for Linux kernel based on sdFAT drivers by Samsung"
HOMEPAGE="https://github.com/arter97/exfat-linux"
SRC_URI="https://github.com/arter97/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}-${PV}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${MY_P}"

BUILD_TARGETS="all"
MODULE_NAMES="exfat(addon:${S})"

PATCHES=(
	"${FILESDIR}"/${P}-make-makefile-gentoo-compat.patch
)

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo "Module parameters"
	einfo "namecase"
	einfo "symlink"
	einfo "errors={continue,panic,remount-ro}"
	einfo "discard"
	einfo "delayed_meta || nodelayed_meta"
}
