#!/bin/bash
# lba2chs.sh --- 
# 
# Filename: lba2chs.sh
# Description: 
# Author: Tharindu Hasthika Bathigama
# Maintainer: 
# Created: Thu Feb 15 06:46:56 2018 (+0530)
# Version: 
# Last-Updated: Thu Feb 15 07:13:45 2018 (+0530)
#           By: Tharindu Hasthika Bathigama
#     Update #: 49
# URL: 
# Keywords: 
# Compatibility: 
# 
# 

# Commentary: 
# 
# 
# 
# 

# Change Log:
# 
# 
# 
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street, Fifth
# Floor, Boston, MA 02110-1301, USA.
# 
# 

# Code:

LBA=
HPC=2
SPT=18

function help {
    echo "${0}: converts Logical Block Address (LBA) to Cylinder Head Sector (CHS)"
    echo "-h, --help            Display Help"
    echo "--lba [n]             Logical Block Address"
    echo "--hpc [n]             Heads per Cylinder (default: 2)"
    echo "--spt [n]             Sectors per Track (default: 18)"
    exit 0
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
	--lba)
	    LBA="$2"
	    shift
	    shift
	    ;;
	--hpc)
	    HPC="$2"
	    shift
	    shift
	    ;;
	--spt)
	    SPT="$2"
	    shift
	    shift
	    ;;
	-h|--help)
	    help $@
	    ;;
	*)
	    POSITIONAL+=("$1")
	    shift
	    ;;
    esac
done

if [[ -z $LBA ]]
then
    help
fi

set -- "${POSITIONAL[@]}"

C=$((LBA / (HPC * SPT)))
H=$(((LBA % (HPC * SPT)) / SPT))
S=$(((LBA % (HPC * SPT)) % SPT + 1))

echo "Cylinder: ${C}"
echo "Head:     ${H}"
echo "Sector:   ${S}"

# 
# lba2chs.sh ends here
