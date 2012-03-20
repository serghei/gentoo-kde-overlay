# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="The KDE Control Center"
HOMEPAGE="https://github.com/serghei/kde3-kdebase"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="samba logitech-mouse ieee1394 opengl doc"


SLOT="3.6"

DEPEND="x11-libs/libX11
    x11-libs/libXext
    x11-libs/libXrender
    x11-libs/libXtst
    x11-libs/libXcursor
    x11-libs/libXrandr
    dev-libs/openssl
    >=media-libs/freetype-2.3
    media-libs/fontconfig
    opengl? ( virtual/opengl )
    samba? ( net-fs/samba )
    logitech-mouse? ( =virtual/libusb-0* )
    ieee1394? ( sys-libs/libraw1394 )
    =kde3-base/kdebase-data-9999
    =kde3-base/kcminit-9999
    =kde3-base/kdelibs-9999
    =kde3-base/kicker-9999
    =kde3-base/libkonq-9999"

RDEPEND="${DEPEND}
        sys-apps/usbutils
        =kde3-base/kcminit-9999
        =kde3-base/kdebase-data-9999
        =kde3-base/kdesu-9999
        =kde3-base/khotkeys-9999
        doc? ( =kde3-base/khelpcenter-9999 )"

S=${WORKDIR}/kdebase

src_configure() {
        mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KCONTROL=ON
		-DWITH_ALL_FEATURES=ON
		-DWITH_USBIDS=/usr/share/misc/usb.ids
		$(cmake-utils_use_with samba SAMBA)
		$(cmake-utils_use_with logitech-mouse LIBUSB)
		$(cmake-utils_use_with ieee1394 LIBRAW1394)
		$(cmake-utils_use_with doc KHELPCENTER)
        )

        cmake-utils_src_configure
}
