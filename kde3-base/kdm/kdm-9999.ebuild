# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="KDE login manager, similar to xdm and gdm"
HOMEPAGE="https://github.com/serghei/kde3-kdebase"

EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86"
IUSE="pam"

SLOT="3.5"

RDEPEND="=kde3-base/kdelibs-9999
	pam? ( kde3-base/kdebase-pam )
	x11-apps/xinit
	x11-apps/xmessage
	x11-libs/libXdmcp
	x11-libs/libXtst
	sys-apps/dbus"
DEPEND="${RDEPEND}"

S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${PREFIX}/lib
		-DGENKDMCONF_FLAGS="--no-old --no-backup --no-in-notice"
		-DBUILD_KDM=ON
		-DWITH_ALL_FEATURES=ON
		$(cmake-utils_use_with pam PAM )
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
		"${D}/${KDEDIR}/share/config/kdm/kdmrc" || die
}

pkg_postinst() {
	# set the default kdm face icon if it's not already set by the system admin
	# because this is user-overrideable in that way, it's not in src_install
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon" ]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/default1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon" ]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/root1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon"
	fi
}
