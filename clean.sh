#!/bin/bash
# ���ܣ�ɾ����ʱ�������ʱ�ļ�
# �÷���

# ��ѹsquashfs��Ŀ¼
ROOTFS=squashfs-root

rm -rf $ROOTFS/var/cache/lsc_packages.db
rm -rf $ROOTFS/var/cache/apt/{pkgcache.bin srcpkgcache.bin}
rm -rf $ROOTFS/var/cache/apt/archives/*.deb
rm -rf $ROOTFS/var/lib/{apt,dpkg,cache,log}
