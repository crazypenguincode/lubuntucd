#!/bin/bash
# �÷���3_build_splash.sh
# ���ܣ�
#  ������������Ϳ�������
#  ��2_tar_splash.sh���ʹ��
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

echo "making boologo"

# �����Ŀ¼����
cd $LOGO_DIR/

# ɾ��֮����Ϊ���ǻ�������
rm -rf bootlogo

# !!!!!!
# ���￪ʼ���ƣ�
cp -rf $WORK_DIR/{splash.pcx,en.tr,zh_CN.tr,zh_TW.tr,txt.cfg} .
cp -rf $WORK_DIR/{splash.pcx,en.tr,zh_CN.tr,zh_TW.tr,txt.cfg} $ISO_IDR/isolinux
# !!!!!!

# ��ȡ��ǰĿ¼�����ļ�
ls > /tmp/list
# ��������bootlogo
cpio -o < /tmp/list > /tmp/bootlogo
# ������ԭʼλ��
mv /tmp/bootlogo $ISO_IDR/isolinux/bootlogo

# ������һ��Ŀ¼
cd -

##############################

echo "making initrd"

cd $INITRD_DIR

# !!!!!!
# ���￪ʼ���ƣ�

mkdir -p /usr/share/plymouth/themes/lubuntu-logo/
mkdir -p /usr/share/plymouth/themes/lubuntu-text/

cp -rf $WORK_DIR/{lubuntu_logo.png,progress_dot_on.png} \
usr/share/plymouth/themes/lubuntu-logo/

# ����2���ļ�Ҫ���Ƶ������ϣ������޷����ֽ���
# ԭ��usr/share/plymouth/themes/��default.plymouth��
# text.plymouth��Ҫ�������ļ���
cp -rf usr/share/plymouth/themes/lubuntu-logo/lubuntu-logo.plymouth \
/usr/share/plymouth/themes/lubuntu-logo/

cp -rf usr/share/plymouth/themes/lubuntu-text/lubuntu-text.plymouth  \
 /usr/share/plymouth/themes/lubuntu-text/

# !!!!!!

# ѹ������������ԭ��λ��
find . | cpio --quiet --dereference -o -H newc | lzma -7 > $ISO_IDR/casper/initrd.lz

cd -