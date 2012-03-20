# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="KDesktop is the KDE interface that handles the icons, desktop popup menus and screensaver system."
HOMEPAGE="https://github.com/serghei/kde3-kdebase"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="pam xscreensaver"

SLOT="3.5"

DEPEND="x11-libs/libXext
    x11-libs/libXrender
    x11-libs/libXfixes
    xscreensaver? ( x11-proto/scrnsaverproto )
    =kde3-base/libkonq-9999"

RDEPEND="${RDEPEND}
    xscreensaver? ( x11-libs/libXScrnSaver )"

S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KDESKTOP=ON
		-DWITH_ALL_FEATURES=ON
		$(cmake-utils_use_with pam PAM)
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
	)

	cmake-utils_src_configure
}
