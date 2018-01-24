#!/bin/bash

# ��ѹsquashfs��Ŀ¼
ROOTFS=$PWD/squashfs-root

WORD_DIR=$PWD/work

#��ʼ��logo
cp $WORD_DIR/destop_images/start/* $ROOTFS/usr/share/lubuntu/images/

# ���汳��ͼƬ
cp $WORD_DIR/destop_images/wallpapers/* $ROOTFS/usr/share/lubuntu/wallpapers/

# web����ҳ��
cp $WORD_DIR/destop_images/startpage/* $ROOTFS/usr/share/lubuntu/startpage

# �ǳ�logoͼƬ
cp $WORD_DIR/destop_images/themes/lubuntu_logo.png $ROOTFS/usr/share/plymouth/themes/lubuntu-logo/


# ��������
cp $WORD_DIR/etc/bash.bashrc $ROOTFS/etc/

# �ն�����
cp $WORD_DIR/etc/lxterminal.conf $ROOTFS/usr/share/lxterminal/

# ʱ��
rm -rf $ROOTFS/etc/localtime
cp $ROOTFS/usr/share/zoneinfo/Asia/Shanghai $ROOTFS/etc/localtime




