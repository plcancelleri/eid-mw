#!/bin/bash

set -e
set -x

if [ -z "$CODE" ] && [ ! -z "$1" ]
then
	CODE=$1
fi
shift
if [ -z "$ARCH" ] && [ ! -z "$1" ]
then
	ARCH=$1
fi
shift
if [ -z "$DIST" ] && [ ! -z "$1" ]
then
	DIST=$1
fi
shift
mkdir -p /srv/chroot
case $DIST in
	debian)
		sbuild-createchroot --arch=$ARCH $CODE /srv/chroot/$CODE http://deb.debian.org/debian
	;;
	ubuntu)
		sbuild-createchroot --arch=$ARCH $CODE /srv/chroot/$CODE http://archive.ubuntu.com/ubuntu /usr/share/debootstrap/scripts/gutsy
	;;
	*)
		echo "E: unknown dist: $DIST" >&2
		exit 1
	;;
esac
