# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
# Edited from nest's overlay: https://data.gpo.zugaina.org/nest/app-emulation/looking-glass/looking-glass-9999.ebuild
#MY_PN="LookingGlass"
#MY_PV="a11"

inherit cmake-utils git-r3
DESCRIPTION="An extremely low latency KVMFR (KVM FrameRelay) implementation for guests with VGA PCI Passthrough"
HOMEPAGE="https://looking-glass.hostfission.com/"
EGIT_REPO_URI="https://github.com/gnif/LookingGlass.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="dev-libs/libconfig
	dev-libs/nettle[gmp]
	media-libs/freetype:2
	media-libs/fontconfig:1.0
	media-libs/libsdl2
	media-libs/sdl2-ttf
	virtual/glu"
DEPEND="${RDEPEND}
	app-emulation/spice-protocol
	virtual/pkgconfig"

CMAKE_USE_DIR="${S}"/client

src_prepare() {
	default

	# Respect FLAGS
	sed -i '/CMAKE_C_FLAGS/s/-O3 -march=native //' \
		client/CMakeLists.txt || die "sed failed for FLAGS"

	if ! use debug ; then
		sed -i '/CMAKE_C_FLAGS/s/-g //' \
		client/CMakeLists.txt || die "sed failed for debug"
	fi

	cmake-utils_src_prepare
}

src_install() {
	einstalldocs

	dobin "${BUILD_DIR}"/looking-glass-client
}

