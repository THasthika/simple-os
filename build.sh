#!/bin/sh
set -e
set -x

. ./scripts/headers.sh

echo "HOST=$HOST"
echo "SYSROOT=$SYSROOT"
echo "CC=$CC"
echo "MAKE=$MAKE"

for PROJECT in $PROJECTS; do
  echo "--- Building $PROJECT ---"
  (cd $PROJECT && DESTDIR="$SYSROOT" $MAKE install)
done