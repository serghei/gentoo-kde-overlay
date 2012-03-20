# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.6

DESCRIPTION="KDE: gui for su(1)"
HOMEPAGE="https://github.com/serghei/kde3-kdebase"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"

SLOT="3.6"

RDEPEND="=kde3-base/kdelibs-9999"
DEPEND="${RDEPEND}"

S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KDESU=ON
		-DWITH_ALL_FEATURES=ON
	)

	cmake-utils_src_configure
}
