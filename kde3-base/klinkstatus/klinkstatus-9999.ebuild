# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="KDE link status checker for html pages"
HOMEPAGE="https://github.com/serghei/kde3-kdewebdev"
EGIT_REPO_URI="file:///home/serghei/projects/kde3-work/kdewebdev"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86"
IUSE=""

SLOT="3.5"

RDEPEND="=kde3-base/kdelibs-9999"

DEPEND="${RDEPEND}"

S=${WORKDIR}/kdewebdev

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KLINKSTATUS=ON
	)

	cmake-utils_src_configure
}
