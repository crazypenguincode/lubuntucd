#!/bin/bash

# ��ѹsquashfs��Ŀ¼

ROOTFS=$PWD/squashfs-root

WORK_DIR=$PWD/work

TOOLS_DIR=$PWD/tools

#��ʼ��logo
cp $WORK_DIR/destop_images/start/* $ROOTFS/usr/share/lubuntu/images/

# ���汳��ͼƬ
cp $WORK_DIR/destop_images/wallpapers/* $ROOTFS/usr/share/lubuntu/wallpapers/

# web����ҳ��
cp $WORK_DIR/destop_images/startpage/* $ROOTFS/usr/share/lubuntu/startpage

# �ǳ�logoͼƬ
cp $WORK_DIR/destop_images/themes/lubuntu_logo.png $ROOTFS/usr/share/plymouth/themes/lubuntu-logo/

# ��������
cp $WORK_DIR/etc/bash.bashrc $ROOTFS/etc/

# �ն�����
cp $WORK_DIR/etc/lxterminal.conf $ROOTFS/usr/share/lxterminal/

# ��ʼ�˵�
cp $WORK_DIR/menu/panel $ROOTFS/usr/share/lxpanel/profile/Lubuntu/panels/

# ׼�����绷��
cat $WORK_DIR/source/n163.list > $ROOTFS/etc/apt/sources.list
cp /etc/resolv.conf $ROOTFS/etc/

# ����Դ
chroot $ROOTFS apt-get update

# ��װ���
chroot $ROOTFS apt-get install -y vim cmake

# <<<<<<<<<< ��װfirefox38
# ������װ��
cp $TOOLS_DIR/firefox-38.0.tar.bz2 $ROOTFS
# ��������ͼ��
cp $ROOTFS/usr/share/lintian/overrides/firefox $WORK_DIR/firefox
cp $ROOTFS/usr/share/applications/firefox.desktop $WORK_DIR/firefox
# ж��Ĭ�ϵ�firefox
chroot $ROOTFS apt-get remove -y firefox
# ��ѹ����װ����������
chroot $ROOTFS tar xjf /firefox-38.0.tar.bz2
chroot $ROOTFS mv /firefox /opt/firefox38
chroot $ROOTFS rm /firefox-38.0.tar.bz2
chroot $ROOTFS ln -s /opt/firefox38/firefox /usr/bin/firefox
#�ָ�����ͼ��
cp $WORK_DIR/firefox/firefox $ROOTFS/usr/share/lintian/overrides/firefox
cp $WORK_DIR/firefox/firefox.desktop $ROOTFS/usr/share/applications/firefox.desktop
# >>>>>>>>>>>>>>>>>>firefox38��װ����

echo "copying desktop..."
# ����ͼ��(��ϵͳ���е�ͼ��ŵ�������)λ��DesktopĿ¼��
mkdir -p $ROOTFS/etc/skel/Desktop
cd $ROOTFS/etc/skel/
# ��������
cp $ROOTFS/usr/share/applications/firefox.desktop ./Desktop
# �ն�
cp $ROOTFS/usr/share/applications/lxterminal.desktop ./Desktop
# ��Ļ��
#cp $ROOTFS/usr/share/applications/lubuntu-screenlock.desktop ./Desktop
#���뷨
cp $ROOTFS/usr/share/applications/fcitx.desktop ./Desktop

# �����ַ�ʽ�����������ubiquity.desktop����˫��ͼ���޷���װ
cp $WORK_DIR/etc/ubiquity.desktop $ROOTFS/usr/share/applications/ubiquity.desktop
cp $WORK_DIR/etc/ubiquity.desktop ./Desktop

# homeĿ¼�͸�Ŀ¼(ע��Ҫ�޸�)
cp $WORK_DIR/etc/pcmanfm_home.desktop ./Desktop
cp $WORK_DIR/etc/pcmanfm_rootfs.desktop ./Desktop

#�����������Ҫ��������ʾ��ͼ��

# ���������ʽ
cp -a $WORK_DIR/lubuntu/.config . 
cp -a $WORK_DIR/lubuntu/.icons .
cp -a $WORK_DIR/lubuntu/.local .

chmod +x *
cd -

# ��ʱ����Ϊ������
chroot $ROOTFS rm /etc/localtime
chroot $ROOTFS ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# ����
chroot $ROOTFS apt-get install -y language-pack-zh-hans language-pack-gnome-zh-hans language-pack-zh-hant language-pack-gnome-zh-hant language-pack-en language-pack-gnome-en

# ���뷨
chroot $ROOTFS apt-get install -y fcitx-pinyin fcitx-table-wubi fcitx-table-wbpy 

exit

# ж�������ع���
# software-properties-gtk �������װ��������������ѡ�����Դ���Ƿ�������
# update-manager �������������ϵͳ��װ����Ҫ����ʱ���������Զ���������
# synaptic�����������������
chroot $ROOTFS apt-get autoremove -y synaptic lubuntu-software-center gdebi software-properties-gtk update-manager

chroot $ROOTFS rm -rf $(find /usr -name "*dpkg*") $(find /usr -name "*apt*")
chroot $ROOTFS rm -rf $(find /etc -name "*dpkg*") $(find /etc -name "*apt*")
