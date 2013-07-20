# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-scanner/openvas-scanner-3.2.4.ebuild,v 1.2 2012/05/04 06:08:11 jdhore Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-scanner)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/873/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug_grade_1 "

RDEPEND=">=net-analyzer/openvas-libraries-4
	!net-analyzer/openvas-plugins
	!net-analyzer/openvas-server"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/cmake"

# Workaround for upstream bug, it doesn't like out-of-tree builds.
CMAKE_BUILD_DIR="${S}"

PATCHES=( "${FILESDIR}/${P}-underlinking.patch" )

src_configure() {
	local mycmakeargs="-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc"
	cmake-utils_src_configure
}

src_install() {
     if use debug_grade_1 ; then
   set -ex
       fi
	cmake-utils_src_install
	dodoc ChangeLog CHANGES README || die "dodoc failed"
	doinitd "${FILESDIR}"/openvassd || die
}

pkg_postinst() {
	elog "To use openvassd, you first need to:"
	elog "1. Call 'openvas-nvt-sync' to download/update plugins"
	elog "2. Call 'openvas-mkcert' to generate a server certificate"
	elog "3. Call 'openvas-adduser' to create a user"
}
