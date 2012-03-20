# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions qt3 git-2
set-kdedir 3.5

DESCRIPTION="KDE libraries needed by all KDE programs."
HOMEPAGE="https://github.com/serghei/kde3-kdelibs"

EGIT_REPO_URI="git://github.com/serghei/kde3-kdelibs.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ~amd64"
IUSE="alsa arts mad audiofile vorbis avahi cups jpeg2k openexr spell tiff lua aspell"

SLOT="3.5"

RDEPEND="dev-libs/openssl
    media-libs/fontconfig
    >=media-libs/freetype-2
    media-libs/libart_lgpl
    net-dns/libidn
    avahi? ( net-dns/avahi[qt3] )
    alsa? ( media-libs/alsa-lib )
    mad? ( media-libs/libmad )
    audiofile? ( media-libs/audiofile )
    vorbis? ( media-libs/libvorbis )
    cups? ( >=net-print/cups-1.1.19 )
    jpeg2k? ( media-libs/jasper )
    openexr? ( >=media-libs/openexr-1.2.2-r2 )
    spell? ( >=app-dicts/aspell-en-6.0.0 >=app-text/aspell-0.60.5 )
    tiff? ( media-libs/tiff )
    lua? ( dev-lang/lua )"

DEPEND="${RDEPEND}
    dev-util/cmake
    dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DWITH_LIBIDN=ON
		-DWITH_SSL=ON
		-DWITH_LIBART=ON
		-DARTS_PREFIX=${PREFIX}
		$(cmake-utils_use_with alsa ALSA)
		$(cmake-utils_use_with arts ARTS)
		$(cmake-utils_use_with mad MAD)
		$(cmake-utils_use_with audiofile AUDIOFILE)
		$(cmake-utils_use_with vorbis VORBIS)
		$(cmake-utils_use_with aspell ASPELL)
		$(cmake-utils_use_with avahi AVAHI)
		$(cmake-utils_use_with cups CUPS)
		$(cmake-utils_use_with jpeg2k JASPER)
		$(cmake-utils_use_with openexr OPENEXR)
		$(cmake-utils_use_with spell ASPELL)
		$(cmake-utils_use_with tiff TIFF)
		$(cmake-utils_use_with lua LUA)
	)

	cmake-utils_src_configure
}
