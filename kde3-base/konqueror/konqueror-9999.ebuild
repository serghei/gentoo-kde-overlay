# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="KDE: Web browser, file manager, ..."
HOMEPAGE="https://github.com/serghei/kde3-kdebase"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

SLOT="3.5"

RDEPEND="=kde3-base/libkonq-9999"

DEPEND="${RDEPEND}
    dev-util/cmake
    dev-util/pkgconfig"

S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KONQUEROR=ON
		-DWITH_ALL_FEATURES=ON
	)

	cmake-utils_src_configure
}
