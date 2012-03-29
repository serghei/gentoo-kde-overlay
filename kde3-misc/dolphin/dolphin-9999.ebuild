# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="A file manager for KDE focusing on usability."
HOMEPAGE="https://github.com/serghei/kde3-apps-dolphin"
EGIT_REPO_URI="git://github.com/serghei/kde3-apps-dolphin.git"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

SLOT="3.5"

RDEPEND="=kde3-base/libkonq-9999"

DEPEND="${RDEPEND}
    dev-util/cmake
    dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
	)

	cmake-utils_src_configure
}
