#!/bin/bash

# chs2lba.sh

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
