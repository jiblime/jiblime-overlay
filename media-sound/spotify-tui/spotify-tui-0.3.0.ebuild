# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
adler32-1.0.3
aho-corasick-0.7.6
ansi_term-0.11.0
arrayref-0.3.5
arrayvec-0.4.11
atty-0.2.13
autocfg-0.1.5
backtrace-0.3.34
backtrace-sys-0.1.31
base64-0.10.1
bitflags-1.1.0
blake2b_simd-0.5.8
byteorder-1.3.2
bytes-0.4.12
c2-chacha-0.2.2
cassowary-0.3.0
cc-1.0.38
cfg-if-0.1.9
chrono-0.4.7
clap-2.33.0
cloudabi-0.0.3
constant_time_eq-0.1.4
cookie-0.12.0
cookie_store-0.7.0
core-foundation-0.6.4
core-foundation-sys-0.6.2
crc32fast-1.2.0
crossbeam-deque-0.7.1
crossbeam-epoch-0.7.2
crossbeam-queue-0.1.2
crossbeam-utils-0.6.6
darling-0.9.0
darling_core-0.9.0
darling_macro-0.9.0
derive_builder-0.7.2
derive_builder_core-0.5.0
dirs-2.0.2
dirs-sys-0.3.4
dotenv-0.13.0
dtoa-0.4.4
either-1.5.2
encoding_rs-0.8.17
env_logger-0.6.2
error-chain-0.12.1
failure-0.1.5
failure_derive-0.1.5
flate2-1.0.9
fnv-1.0.6
foreign-types-0.3.2
foreign-types-shared-0.1.1
fuchsia-cprng-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.28
futures-cpupool-0.1.8
getrandom-0.1.8
h2-0.1.26
http-0.1.18
http-body-0.1.0
httparse-1.3.4
humantime-1.2.0
hyper-0.12.33
hyper-tls-0.3.2
ident_case-1.0.1
idna-0.1.5
indexmap-1.0.2
iovec-0.1.2
itertools-0.8.0
itoa-0.4.4
kernel32-sys-0.2.2
lazy_static-1.3.0
libc-0.2.61
linked-hash-map-0.5.2
lock_api-0.1.5
log-0.4.8
matches-0.1.8
memchr-2.2.1
memoffset-0.5.1
mime-0.3.13
mime_guess-2.0.1
miniz_oxide-0.3.2
miniz_oxide_c_api-0.2.3
mio-0.6.19
miow-0.2.1
native-tls-0.2.3
net2-0.2.33
nodrop-0.1.13
num-integer-0.1.41
num-traits-0.2.8
num_cpus-1.10.1
numtoa-0.1.0
openssl-0.10.24
openssl-probe-0.1.2
openssl-sys-0.9.48
owning_ref-0.4.0
parking_lot-0.7.1
parking_lot_core-0.4.0
percent-encoding-1.0.1
pkg-config-0.3.15
ppv-lite86-0.2.5
proc-macro2-0.4.30
publicsuffix-1.5.2
quick-error-1.2.2
quote-0.6.13
rand-0.6.5
rand-0.7.0
rand_chacha-0.1.1
rand_chacha-0.2.1
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.0
rand_hc-0.1.0
rand_hc-0.2.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_xorshift-0.1.1
random-0.12.2
rdrand-0.4.0
redox_syscall-0.1.56
redox_termios-0.1.1
redox_users-0.3.1
regex-1.2.1
regex-syntax-0.6.11
remove_dir_all-0.5.2
reqwest-0.9.19
rspotify-0.6.0
rust-argon2-0.5.1
rustc-demangle-0.1.15
rustc-serialize-0.3.24
rustc_version-0.2.3
ryu-1.0.0
schannel-0.1.15
scopeguard-0.3.3
scopeguard-1.0.0
security-framework-0.3.1
security-framework-sys-0.3.1
semver-0.9.0
semver-parser-0.7.0
serde-1.0.98
serde_derive-1.0.98
serde_json-1.0.40
serde_urlencoded-0.5.5
serde_yaml-0.8.9
slab-0.4.2
smallvec-0.6.10
stable_deref_trait-1.1.1
string-0.2.1
strsim-0.7.0
strsim-0.8.0
syn-0.15.44
synstructure-0.10.2
tempfile-3.1.0
termcolor-1.0.5
termion-1.5.3
textwrap-0.11.0
thread_local-0.3.6
time-0.1.42
tokio-0.1.22
tokio-buf-0.1.1
tokio-current-thread-0.1.6
tokio-executor-0.1.8
tokio-io-0.1.12
tokio-reactor-0.1.9
tokio-sync-0.1.6
tokio-tcp-0.1.3
tokio-threadpool-0.1.15
tokio-timer-0.2.11
try-lock-0.2.2
try_from-0.3.2
tui-0.6.2
unicase-2.4.0
unicode-bidi-0.3.4
unicode-normalization-0.1.8
unicode-segmentation-1.3.0
unicode-width-0.1.5
unicode-xid-0.1.0
url-1.7.2
uuid-0.7.4
vcpkg-0.2.7
vec_map-0.8.1
version_check-0.1.5
want-0.2.0
webbrowser-0.5.1
widestring-0.4.0
winapi-0.2.8
winapi-0.3.7
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.2
winapi-x86_64-pc-windows-gnu-0.4.0
wincolor-1.0.1
winreg-0.6.2
ws2_32-sys-0.2.1
yaml-rust-0.4.3
"
inherit cargo

DESCRIPTION="A Spotify client for the terminal written in Rust"
HOMEPAGE="https://github.com/Rigellute/spotify-tui"

if [ ${PV} == "9999" ] ; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/Rigellute/spotify-tui"
else
        SRC_URI="https://github.com/Rigellute/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
        $(cargo_crate_uris ${CRATES})"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	einfo "that shows currently implemented key events and their actions."
        einfo 'The created config is located at ${HOME}/.config/spotify-tui/client.yml.'
}
