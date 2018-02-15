#!/bin/bash

# lba2chs.sh --- 

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
