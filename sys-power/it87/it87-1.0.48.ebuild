# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod
# Inherting linux-info to check the kernel config causes the ebuild to fail

MY_PV=v1.0
MY_PN=hwmon-it87
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="An out-of-tree module of it87 by Guenter Roeck"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://github.com/xdarklight/hwmon-it87/archive/v1.0.tar.gz -> ${MY_PN}-1.0.48_g40bec4b.tar.gz"
# This is a mirror

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/hwmon-it87-1.0"

BUILD_TARGETS="modules"
MODULE_NAMES="it87(misc:${S})"

src_install() {
	linux-mod_src_install
	insinto /usr/lib/modules-load.d
	doins "${FILESDIR}"/it87.conf
	insinto /etc/modprobe.d
	doins "${FILESDIR}"/it87-ignore_resource_conflict.conf
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "The module's official version: 1.0.48_g40bec4b"
	elog "This module's development has been discontinued since July 2018. Despite such, this module still can provide more information for your motherboard over the in-kernel version. You can view current in-kernel development at the URL below and decide which one you'd rather use"
	elog "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=it87"
	elog "The option ignore_resource_conflict has been enabled with /etc/modprobe.d/it87.conf for convenience. Alternatively acpi_enforce_resources=lax can be set at the kernel commandline"
	elog "This ebuild does not check whether or not SENSORS_IT87 is set in the kernel config. If it is, it should be rebuilt without it to prevent conflicts"

}
