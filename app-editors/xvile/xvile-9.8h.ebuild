# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xvile/xvile-9.8h.ebuild,v 1.1 2012/08/28 08:35:45 radhermit Exp $

EAPI="4"

inherit eutils

MY_P="${PN/x/}-${PV}"
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
HOMEPAGE="http://invisible-island.net/vile/"
SRC_URI="ftp://invisible-island.net/vile/current/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="debug_grade_1 perl"

RDEPEND="perl? ( dev-lang/perl )
	=app-editors/vile-${PV}
	>=x11-libs/libX11-1.0.0
	>=x11-libs/libXt-1.0.0
	>=x11-libs/libICE-1.0.0
	>=x11-libs/libSM-1.0.0
	>=x11-libs/libXaw-1.0.1
	>=x11-libs/libXpm-3.5.4.2
	>=x11-proto/xproto-7.0.4"
DEPEND="${RDEPEND}
	sys-devel/flex"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${MY_P}-flex.patch
	epatch "${FILESDIR}"/${MY_P}-xsubpp.patch
}

src_configure() {
	econf \
		--with-ncurses \
		--with-x \
		$(use_with perl)
}

src_install() {
     if use debug_grade_1 ; then
   set -ex
       fi
	dobin xvile
	dodoc CHANGES* README doc/*.doc
	dohtml doc/*.html
}
