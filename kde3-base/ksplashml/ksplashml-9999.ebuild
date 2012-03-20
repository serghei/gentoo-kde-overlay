# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="KDE splashscreen framework (the splashscreen of KDE itself, not of individual apps)"
HOMEPAGE="https://github.com/serghei/kde3-kdebase"

EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="xinerama"

SLOT="3.5"

DEPEND="x11-libs/libXcursor
	xinerama? ( x11-proto/xineramaproto )
	=kde3-base/kdelibs-9999"

RDEPEND="x11-libs/libXcursor
        xinerama? ( x11-libs/libXinerama )"

S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KSPLASHML=ON
		-DWITH_ALL_FEATURES=ON
		$(cmake-utils_use_with xinerama XINERAMA)
	)

	cmake-utils_src_configure
}
