# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="KMail is the email component of Kontact, the integrated personal information manager of KDE."
HOMEPAGE="https://github.com/serghei/kde3-kdepim"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdepim.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

SLOT="3.5"

RDEPEND="=kde3-base/libkmime-9999
    =kde3-base/libkpgp-9999
    =kde3-base/libkdepim-9999
    =kde3-base/libkpimidentities-9999
    =kde3-base/mimelib-9999
    =kde3-base/libksieve-9999
    =kde3-base/kdepim-kioslaves-9999"
DEPEND="${RDEPEND}"

S=${WORKDIR}/kdepim

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KMAIL=ON
		-DBUILD_PLUGINS=ON
	)

	cmake-utils_src_configure
}
