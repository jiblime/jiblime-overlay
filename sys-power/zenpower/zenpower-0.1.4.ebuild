# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod
# Inherting linux-info to check the kernel config causes the ebuild to fail

DESCRIPTION="An out-of-tree module of it87 by Guenter Roeck"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

if [ ${PV} == "9999" ] ; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/ocerman/zenmonitor"
else
        SRC_URI="https://github.com/ocerman/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

BUILD_TARGETS="modules"
MODULE_NAMES="zenpower(misc:${S})"

PATCHES=(
	"${FILESDIR}"/${P}-Added-KERNEL_MODULES-variable-to-the-Makefile.patch
)

pkg_setup() {
	linux-mod_pkg_setup
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo "The module is installed as zenpower.ko"
}
