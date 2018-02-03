#!/bin/bash
# �÷���./2_tar_splash.sh
# ���ܣ�
#  ��ѹ������������Ϳ��������ļ�
#  ��3_build_splash.sh���ʹ��
# Ŀ¼��
# $ISO_IDR�������ƶ�iso��Ҫ��Դ�ļ�
# $LOGO_DIR�������ʼ�������ʾ�������á���װѡ�
# $INITRD_DIR�����𿪻����̵Ľ�����ʾ

# ��Ҫ���Ƶ��ļ�Ŀ¼
WORK_DIR=$PWD/work/splash

# ������ʱĿ¼
SPLASH_DIR=$PWD/splash_dir

LOGO_DIR=$SPLASH_DIR/bootlogo

INITRD_DIR=$SPLASH_DIR/initrd


# ���̽�ѹ���Ŀ¼
ISO_IDR=$PWD/newiso

# ��֤��rootȨ��
if [ `whoami` != "root" ];then
    echo "you are not root! try: sudo -s"
    exit
fi

mkdir -p $SPLASH_DIR
mkdir -p $LOGO_DIR
mkdir -p $INITRD_DIR

# ��ɾ���ļ�����������еĻ�
rm -rf $LOGO_DIR/* $INITRD_DIR/*

# ����bootlogo��$LOGO_DIRĿ¼
cp $ISO_IDR/isolinux/bootlogo $LOGO_DIR/

# �����Ŀ¼����
cd $LOGO_DIR/

# ��ѹbootlogo�ļ�
cpio -idmv < bootlogo
# ɾ��֮����Ϊ���ǻ�������
rm -rf bootlogo

##############################

cd $INITRD_DIR
lzma -dc -S .lz $ISO_IDR/casper/initrd.lz | cpio -id

# !!!!!!
# ���￪ʼ���ƣ�
