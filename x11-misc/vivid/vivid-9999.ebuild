# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
ansi_colours-1.0.1
ansi_term-0.11.0
atty-0.2.11
bitflags-1.0.4
cc-1.0.25
clap-2.32.0
kernel32-sys-0.2.2
lazy_static-1.2.0
libc-0.2.44
linked-hash-map-0.5.1
redox_syscall-0.1.43
redox_termios-0.1.1
strsim-0.7.0
term_size-0.3.1
termion-1.5.1
textwrap-0.10.0
unicode-width-0.1.5
vec_map-0.8.1
winapi-0.2.8
winapi-0.3.6
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
yaml-rust-0.4.2
"
inherit cargo flag-o-matic

DESCRIPTION="A Spotify client for the terminal written in Rust"
HOMEPAGE="https://github.com/sharkdp/vivid/"

if [ ${PV} == "9999" ] ; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/sharkdp/vivid"
else
        SRC_URI="https://github.com/sharkdp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
        $(cargo_crate_uris ${CRATES})"
fi

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="
        virtual/rust
"

DOCS=( CHANGELOG.md README.md help.yml )

QA_FLAGS_IGNORED="usr/bin/vivid"

src_unpack() {
        if [[ "${PV}" == *9999* ]]; then
                git-r3_src_unpack
                cargo_live_src_unpack
        else
                cargo_src_unpack
        fi
}

src_configure() {
	test-flags -flto* && append-flags -ffat-lto-objects &&
	elog "Applied -ffat-lto-objects because of -flto in your *FLAGS. Some Cargo based packages fail because of LTO and this is one of them"
}

src_install() {
        cargo_src_install --path=.

	insinto /usr/share/vivid
	doins -r config/filetypes.yml

	insinto /usr/share/vivid/themes
	doins -r themes/*
}

pkg_postinst() {
	einfo "Built in themes for version ${PV}:"
	einfo "$(ls ${EPREFIX}/usr/share/vivid/themes/* | sed 's/^\/.*themes\/\(.*\)\.yml/\1/g')"
	einfo 'Example of adding vivid to your ~/.bashrc | ~/.zshrc | ~/.yourshellrc'
	einfo '		export LS_COLORS="$(vivid -d /usr/share/vivid/filetypes.yml generate molokai)"'
}

