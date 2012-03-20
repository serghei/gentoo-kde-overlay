# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils kde-functions git-2
set-kdedir 3.5

DESCRIPTION="Icons, localization data and .desktop files from kdebase. Includes l10n, pics and applnk subdirs."
HOMEPAGE="https://github.com/serghei/kde3-kdebase"
EGIT_REPO_URI="git://github.com/serghei/kde3-kdebase.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

SLOT="3.5"

S=${WORKDIR}/kdebase

src_configure() {
        mycmakeargs=(
                -DBUILD_L10N=ON
                -DBUILD_PICS=ON
                -DBUILD_APPLNK=ON
        )

        cmake-utils_src_configure
}
