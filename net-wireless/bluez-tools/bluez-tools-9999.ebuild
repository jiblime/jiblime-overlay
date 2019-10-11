# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils

DESCRIPTION="A set of tools to manage bluetooth devices for linux"
HOMEPAGE="https://github.com/khvzak/bluez-tools"
LICENSE="GPL-2+"
SLOT="0"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/khvzak/bluez-tools.git"
	inherit git-r3
else
	COMMIT="97efd293491ad7ec96a655665339908f2478b3d1"
	SRC_URI="https://github.com/khvzak/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.36.0
	net-wireless/bluez[obex]
	sys-libs/readline:0"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README )

S="${WORKDIR}/${PN}-${PV}"

src_prepare () {
	eautoreconf
	default_src_prepare
}
