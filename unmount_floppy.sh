if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

hdiutil unmount $1

# detach the disk
hdiutil detach $1

echo "Disk Unmounted!"