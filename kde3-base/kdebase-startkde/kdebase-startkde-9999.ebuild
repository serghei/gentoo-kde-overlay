# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="startkde script, which starts a complete KDE session, and associated scripts"
HOMEPAGE="https://github.com/serghei/kde3-kdebase"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"

SLOT="3.5"

RDEPEND="x11-apps/xmessage
        x11-apps/xsetroot
        x11-apps/xset
        x11-apps/xrandr
        x11-apps/mkfontdir
        x11-apps/xprop
        =kde3-base/konsole-9999
        =kde3-base/kdesktop-9999
        =kde3-base/kcminit-9999
        =kde3-base/ksmserver-9999
        =kde3-base/kwin-9999
        =kde3-base/kpersonalizer-9999
        =kde3-base/kreadconfig-9999
        =kde3-base/ksplashml-9999
        =kde3-base/kicker-9999
        =kde3-base/kdebase-data-9999
        =kde3-base/kdebase-kioslaves-9999"

PATCHES=( "${FILESDIR}/${PN}-3.5-gentoo.patch" )

S=${WORKDIR}/kdebase


src_configure() {
        mycmakeargs=(
                -DBUILD_STARTKDE=ON
        )
        cmake-utils_src_configure
}

src_install() {
	# startkde script
	exeinto "${KDEDIR}/bin"
	doexe startkde

	# startup and shutdown scripts
	exeinto "${KDEDIR}/env"
	doexe "${FILESDIR}/agent-startup.sh"

	exeinto "${KDEDIR}/shutdown"
	doexe "${FILESDIR}/agent-shutdown.sh"

	# freedesktop environment variables
	cat <<EOF > "${T}/xdg.sh"
export XDG_CONFIG_DIRS="${KDEDIR}/etc/xdg"
EOF
	exeinto "${KDEDIR}/env"
	doexe "${T}/xdg.sh"

	# x11 session script
	cat <<EOF > "${T}/kde-${SLOT}"
#!/bin/sh
exec ${KDEDIR}/bin/startkde
EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/kde-${SLOT}"

	# (not really) freedesktop compliant session script
	sed -e "s:@KDE_BINDIR@:${KDEDIR}/bin:g;s:Name=KDE:Name=KDE ${SLOT}:" \
		"${S}/kdm/kfrontend/sessions/kde.desktop.in" > "${T}/kde-${SLOT}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/kde-${SLOT}.desktop"
}

pkg_postinst () {
	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	elog "edit ${KDEDIR}/env/agent-startup.sh and"
	elog "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
