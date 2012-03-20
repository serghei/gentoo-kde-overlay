# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="kioslave: the KDE VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
HOMEPAGE="https://github.com/serghei/kde3-kdebase"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="samba ldap sasl openexr"

SLOT="3.5"

RDEPEND="=kde3-base/kdelibs-9999
    x11-libs/libXcursor
    openexr? ( >=media-libs/openexr-1.2.2-r2 )
    samba? ( net-fs/samba )
    ldap? ( net-nds/openldap )
    sasl? ( dev-libs/cyrus-sasl )"

DEPEND="${RDEPEND}
    dev-util/cmake
    dev-util/pkgconfig"

S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KIOSLAVES=ON
		-DWITH_ALL_FEATURES=ON
		$(cmake-utils_use_with samba SAMBA)
		$(cmake-utils_use_with ldap LDAP)
		$(cmake-utils_use_with sasl SASL)
		$(cmake-utils_use_with openexr OPENEXR)
	)

	cmake-utils_src_configure
}
