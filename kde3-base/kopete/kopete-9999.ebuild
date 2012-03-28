# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="https://github.com/serghei/kde3-kdenetwork"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdenetwork.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"

SLOT="3.5"

IUSE="xscreensaver opengl ssl"
PLUGINS="addbookmarks alias autoreplace connectionstatus notes crypt highlight history latex motionauto nowlistening statistics texteffect translator webpresence"
PROTOCOLS="gadu groupwise irc jabber jingle meanwhile oscar sms winpopup yahoo"
IUSE="${IUSE} ${PLUGINS} ${PROTOCOLS}"

# The kernel_linux? ( ) conditional dependencies are for webcams, not supported
# on other kernels AFAIK
BOTH_DEPEND="=kde3-base/kdelibs-9999
        =app-crypt/qca-1*
        >=dev-libs/glib-2
        dev-libs/libxml2
        dev-libs/libxslt
        x11-libs/libX11
        x11-libs/libXext
        x11-libs/libXrender
        media-libs/libv4l
        jabber? ( net-dns/libidn )
        jingle? ( dev-libs/expat media-libs/speex )
        kernel_linux? ( virtual/opengl )
        xscreensaver? ( x11-libs/libXScrnSaver )
        opengl? ( x11-libs/qt-meta:3[opengl] )"

RDEPEND="${BOTH_DEPEND}
        gadu? ( net-libs/libgadu )
        jabber? ( net-dns/libidn )
        meanwhile? ( net-libs/meanwhile )
        crypt? ( app-crypt/gnupg )
        latex? ( media-gfx/imagemagick virtual/latex-base )
        ssl? ( =app-crypt/qca-tls-1* )"

DEPEND="${BOTH_DEPEND}
        x11-proto/videoproto
        kernel_linux? ( virtual/os-headers x11-libs/libXv )
        xscreensaver? ( x11-proto/scrnsaverproto )"

S=${WORKDIR}/kdenetwork

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DBUILD_KOPETE=ON
		$(cmake-utils_use_build gadu KOPETE_PROTOCOL_GADU)
		$(cmake-utils_use_build groupwise KOPETE_PROTOCOL_GROUPWISE)
		$(cmake-utils_use_build irc KOPETE_PROTOCOL_IRC)
		$(cmake-utils_use_build jabber KOPETE_PROTOCOL_JABBER)
		$(cmake-utils_use_with jingle JINGLE)
		$(cmake-utils_use_with cam WEBCAM)
		$(cmake-utils_use_build meanwhile KOPETE_PROTOCOL_MEANWHILE)
		$(cmake-utils_use_build oscar KOPETE_PROTOCOL_OSCAR)
		$(cmake-utils_use_build winpopup KOPETE_PROTOCOL_WINPOPUP)
		$(cmake-utils_use_build yahoo KOPETE_PROTOCOL_YAHOO)
		$(cmake-utils_use_build addbookmarks KOPETE_PLUGIN_ADDBOOKMARKS)
		$(cmake-utils_use_build alias KOPETE_PLUGIN_ALIAS)
		$(cmake-utils_use_build autoreplace KOPETE_PLUGIN_AUTOREPLACE)
		$(cmake-utils_use_build connectionstatus KOPETE_PLUGIN_CONNECTIONSTATUS)
		$(cmake-utils_use_build notes KOPETE_PLUGIN_NOTES)
		$(cmake-utils_use_build crypt KOPETE_PLUGIN_CRYPTOGRAPHY)
		$(cmake-utils_use_build highlight KOPETE_PLUGIN_HIGHLIGHT)
		$(cmake-utils_use_build history KOPETE_PLUGIN_HISTORY)
		$(cmake-utils_use_build latex  KOPETE_PLUGIN_LATEX)
		$(cmake-utils_use_build motionauto KOPETE_PLUGIN_MOTIONAUTO)
		$(cmake-utils_use_build nowlistening KOPETE_PLUGIN_NOWLISTENING)
		$(cmake-utils_use_build statistics KOPETE_PLUGIN_STATISTICS) 
		$(cmake-utils_use_build texteffect KOPETE_PLUGIN_TEXTEFFECT)
		$(cmake-utils_use_build translator KOPETE_PLUGIN_TRANSLATOR)
		$(cmake-utils_use_build webpresence KOPETE_PLUGIN_WEBPRESENCE)
	)

	cmake-utils_src_configure
}
