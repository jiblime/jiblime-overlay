# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
adler32-1.0.4
aho-corasick-0.7.6
ansi_term-0.11.0
atty-0.2.13
autocfg-0.1.7
backtrace-sys-0.1.32
backtrace-0.3.40
base64-0.10.1
bitflags-1.2.1
byteorder-1.3.2
bytes-0.4.12
cassowary-0.3.0
cc-1.0.47
cfg-if-0.1.10
chrono-0.4.9
clap-2.33.0
clipboard-0.5.0
cookie_store-0.7.0
cookie-0.12.0
crc32fast-1.2.0
crossbeam-deque-0.7.2
crossbeam-epoch-0.8.0
crossbeam-queue-0.1.2
crossbeam-utils-0.6.6
crossbeam-utils-0.7.0
darling_core-0.9.0
darling_macro-0.9.0
darling-0.9.0
derive_builder_core-0.5.0
derive_builder-0.7.2
dirs-sys-0.3.4
dirs-2.0.2
dotenv-0.13.0
dtoa-0.4.4
either-1.5.3
encoding_rs-0.8.20
env_logger-0.6.2
error-chain-0.12.1
failure_derive-0.1.6
failure-0.1.6
flate2-1.0.13
fnv-1.0.6
foreign-types-shared-0.1.1
foreign-types-0.3.2
futures-cpupool-0.1.8
futures-0.1.29
h2-0.1.26
httparse-1.3.4
http-body-0.1.0
http-0.1.19
humantime-1.3.0
hyper-tls-0.3.2
hyper-0.12.35
ident_case-1.0.1
idna-0.1.5
idna-0.2.0
indexmap-1.3.0
iovec-0.1.4
itertools-0.8.1
itoa-0.4.4
lazy_static-1.4.0
libc-0.2.65
linked-hash-map-0.5.2
lock_api-0.3.1
log-0.4.8
matches-0.1.8
maybe-uninit-2.0.0
memchr-2.2.1
memoffset-0.5.3
mime_guess-2.0.1
mime-0.3.14
miniz_oxide-0.3.5
mio-0.6.19
native-tls-0.2.3
net2-0.2.33
num_cpus-1.11.1
num-integer-0.1.41
numtoa-0.1.0
num-traits-0.2.9
openssl-probe-0.1.2
openssl-sys-0.9.52
openssl-0.10.25
parking_lot_core-0.6.2
parking_lot-0.9.0
percent-encoding-1.0.1
percent-encoding-2.1.0
pkg-config-0.3.17
proc-macro2-0.4.30
proc-macro2-1.0.6
publicsuffix-1.5.4
quick-error-1.2.2
quote-0.6.13
quote-1.0.2
rand_chacha-0.1.1
rand_core-0.3.1
rand_core-0.4.2
rand_hc-0.1.0
rand_isaac-0.1.1
rand_jitter-0.1.4
random-0.12.2
rand_os-0.1.3
rand_pcg-0.1.2
rand-0.6.5
rand_xorshift-0.1.1
regex-syntax-0.6.12
regex-1.3.1
reqwest-0.9.17
rspotify-0.7.0
rustc-demangle-0.1.16
rustc-serialize-0.3.24
rustc_version-0.2.3
ryu-1.0.2
scopeguard-1.0.0
semver-parser-0.7.0
semver-0.9.0
serde_derive-1.0.103
serde_json-1.0.41
serde_urlencoded-0.5.5
serde-1.0.103
serde_yaml-0.8.11
slab-0.4.2
smallvec-0.6.13
smallvec-1.0.0
string-0.2.1
strsim-0.7.0
strsim-0.8.0
synstructure-0.12.3
syn-0.15.44
syn-1.0.8
termcolor-1.0.5
termion-1.5.4
textwrap-0.11.0
thread_local-0.3.6
time-0.1.42
tokio-buf-0.1.1
tokio-current-thread-0.1.6
tokio-executor-0.1.8
tokio-io-0.1.12
tokio-reactor-0.1.10
tokio-sync-0.1.7
tokio-tcp-0.1.3
tokio-threadpool-0.1.16
tokio-timer-0.2.11
tokio-0.1.22
try_from-0.3.2
try-lock-0.2.2
tui-0.7.0
unicase-2.6.0
unicode-bidi-0.3.4
unicode-normalization-0.1.10
unicode-segmentation-1.6.0
unicode-width-0.1.6
unicode-xid-0.1.0
unicode-xid-0.2.0
url-1.7.2
url-2.1.0
uuid-0.7.4
vec_map-0.8.1
version_check-0.1.5
version_check-0.9.1
want-0.2.0
webbrowser-0.5.2
winapi-0.3.8
x11-clipboard-0.3.3
xcb-0.8.2
yaml-rust-0.4.3
"
inherit cargo

DESCRIPTION="A Spotify client for the terminal written in Rust"
HOMEPAGE="https://github.com/Rigellute/spotify-tui"

MY_PV="v${PV}"

if [ ${PV} == "9999" ] ; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/Rigellute/spotify-tui.git"
else
        SRC_URI="https://github.com/Rigellute/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
        $(cargo_crate_uris ${CRATES})"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

BDEPEND="
	virtual/rust
"

DOCS=( CHANGELOG.md README.md help.yml )

QA_FLAGS_IGNORED="usr/bin/spt"

src_unpack() {
        if [[ "${PV}" == *9999* ]]; then
                git-r3_src_unpack
                cargo_live_src_unpack
        else
                cargo_src_unpack
        fi
}

src_install() {
	cargo_src_install --path=.
}

pkg_postinst() {
	einfo "A Spotify premium account is required to connect to the developer API."
	einfo ""
	einfo "spotify-tui is installed as ${EPREFIX}/usr/bin/spt."
	einfo ""
	einfo "When running spotify-tui press ? to bring up a help menu"
	einfo "that shows currently implemented key events and their actions"
        einfo 'The created config is located at ${HOME}/.config/spotify-tui/client.yml'
}
