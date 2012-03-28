# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="kioslaves from kdepim package"
HOMEPAGE="https://github.com/serghei/kde3-kdepim"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdepim.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64" 
IUSE="sasl"

SLOT="3.5"

RDEPEND="sasl? ( >=dev-libs/cyrus-sasl-2 )
    =kde3-base/libkmime-9999"

DEPEND="${RDEPEND}"

S=${WORKDIR}/kdepim

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KIOSLAVES=ON
		$(cmake-utils_use_with sasl SASL )
	)

	cmake-utils_src_configure
}
