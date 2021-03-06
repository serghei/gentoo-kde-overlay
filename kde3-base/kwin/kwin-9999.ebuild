# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="KDE window manager"
HOMEPAGE="https://github.com/serghei/kde3-kdebase"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="xcomposite"

SLOT="3.5"

RDEPEND="x11-libs/libXext
    x11-libs/libXrender
    x11-libs/libXfixes
    x11-libs/libXext
    xcomposite? ( x11-libs/libXcomposite )
    =kde3-base/kdelibs-9999"

DEPEND="${RDEPEND}"

S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KWIN=ON
		-DWITH_ALL_FEATURES=ON
		$(cmake-utils_use_with xcomposite XCOMPOSITE)
	)

	cmake-utils_src_configure
}
