#!/bin/bash
# chs2lba.sh --- 
# 
# Filename: chs2lba.sh
# Description: 
# Author: Tharindu Hasthika Bathigama
# Maintainer: 
# Created: Thu Feb 15 06:46:54 2018 (+0530)
# Version: 
# Last-Updated: Thu Feb 15 07:19:20 2018 (+0530)
#           By: Tharindu Hasthika Bathigama
#     Update #: 14
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

C=
H=
S=
HPC=2
SPT=18

function help {
    echo "${0}: converts Logical Block Address (LBA) to Cylinder Head Sector (CHS)"
    echo "-h, --help            Display Help"
    echo "-s, --sector [n]      Sector Index (starts from 1)"
    echo "-c, --cylinder [n]    Cylinder Index (starts from 0)"
    echo "-h, --head [n]        Head Index (starts from 0)"
    echo "--hpc [n]             Heads per Cylinder (default: 2)"
    echo "--spt [n]             Sectors per Track (default: 18)"
    exit 0
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -s|--sector)
	    S="$2"
	    shift
	    shift
	    ;;
	-h|--head)
	    H="$2"
	    shift
	    shift
	    ;;
	-c|--cylinder)
	    C="$2"
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

if [[ -z $C || -z $H || -z $S ]]
then
    help
fi

set -- "${POSITIONAL[@]}"

LBA=$((((C * HPC + H) * SPT) + S - 1))

echo "LBA: ${LBA}"

# 
# chs2lba.sh ends here
