# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools git-r3

DESCRIPTION="DDCControl monitor database"
HOMEPAGE="https://github.com/ddccontrol/${PN}"
EGIT_REPO_URI=https://github.com/ddccontrol/${PN}.git

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

BDEPEND="dev-lang/perl"

RDEPEND="nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
		dev-util/intltool
		dev-perl/XML-Parser"

src_prepare() {
	touch db/options.xml.h ABOUT-NLS config.rpath || die
	eautoreconf
}

src_configure() {
	MAKEOPTS=""
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README.md
}
