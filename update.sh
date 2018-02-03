#!/bin/bash
# ����rootfs

# Ŀ¼����
ROOTFS=$PWD/squashfs-root

WORK_DIR=$PWD/work

TOOLS_DIR=$PWD/tools

############# ��ʼ��logo
cp $WORK_DIR/destop_images/start/* $ROOTFS/usr/share/lubuntu/images/

############# ���汳��ͼƬ
cp $WORK_DIR/destop_images/wallpapers/* $ROOTFS/usr/share/lubuntu/wallpapers/

############# web����ҳ��
cp $WORK_DIR/destop_images/startpage/* $ROOTFS/usr/share/lubuntu/startpage

############# �ǳ�logoͼƬ
cp $WORK_DIR/destop_images/themes/lubuntu_logo.png $ROOTFS/usr/share/plymouth/themes/lubuntu-logo/

############# ��������
cp $WORK_DIR/etc/bash.bashrc $ROOTFS/etc/

############# �ն�����
cp $WORK_DIR/etc/lxterminal.conf $ROOTFS/usr/share/lxterminal/

############# ׼�����绷��
cat $WORK_DIR/source/n163.list > $ROOTFS/etc/apt/sources.list
cp /etc/resolv.conf $ROOTFS/etc/

############# ����Դ
chroot $ROOTFS apt-get update

############# ��װ���
chroot $ROOTFS apt-get install -y vim cmake

# <<<<<<<<<< ��װfirefox38
# ������װ��
mkdir -p $TOOLS_DIR

if [ ! -f $TOOLS_DIR/firefox-38.0.tar.bz2 ]; then
echo "downloading firefox..."
wget -P $TOOLS_DIR http://releases.mozilla.org/pub/firefox/releases/38.0/linux-x86_64/zh-CN/firefox-38.0.tar.bz2
fi

cp $TOOLS_DIR/firefox-38.0.tar.bz2 $ROOTFS
# ��������ͼ��
cp $ROOTFS/usr/share/lintian/overrides/firefox $WORK_DIR/firefox
cp $ROOTFS/usr/share/applications/firefox.desktop $WORK_DIR/firefox
# ж��Ĭ�ϵ�firefox
chroot $ROOTFS apt-get remove -y firefox
# ��ѹ����װ����������
chroot $ROOTFS rm -rf /opt/firefox /usr/bin/firefox
chroot $ROOTFS tar xjf /firefox-38.0.tar.bz2 -C /opt
chroot $ROOTFS rm -rf /firefox-38.0.tar.bz2
chroot $ROOTFS ln -s /opt/firefox/firefox /usr/bin/firefox
# (ע������������ͼ��ʹ�õ���x-www-browser����)
chroot $ROOTFS ln -s /usr/bin/firefox /usr/bin/x-www-browser

#�ָ�����ͼ��
cp $WORK_DIR/firefox/firefox $ROOTFS/usr/share/lintian/overrides/firefox
cp $WORK_DIR/firefox/firefox.desktop $ROOTFS/usr/share/applications/firefox.desktop
# >>>>>>>>>>>>>>>>>>firefox38��װ����

echo "copying desktop..."

mkdir -p $ROOTFS/etc/skel/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

NEW_DESKTOP=$ROOTFS/etc/skel/Desktop

############## ����ͼ��(��ϵͳ���е�ͼ��ŵ�������)λ��DesktopĿ¼��
# ��������
cp $ROOTFS/usr/share/applications/firefox.desktop $NEW_DESKTOP
# �ն�
cp $ROOTFS/usr/share/applications/lxterminal.desktop $NEW_DESKTOP

# �����ַ�ʽ�����������ubiquity.desktop����˫��ͼ���޷���װ
# ע��ubiquity.desktop�Ѿ��޸Ĺ���
cp $WORK_DIR/etc/ubiquity.desktop $ROOTFS/usr/share/applications/ubiquity.desktop
cp $WORK_DIR/etc/ubiquity.desktop $NEW_DESKTOP

# homeĿ¼�͸�Ŀ¼(ע���˶������¼ӵ�)
cp $WORK_DIR/etc/pcmanfm_home.desktop $NEW_DESKTOP
cp $WORK_DIR/etc/pcmanfm_rootfs.desktop $NEW_DESKTOP

#�����������Ҫ��������ʾ��ͼ��

############## ���������ʽ������
cp -a $WORK_DIR/lubuntu/.config $NEW_DESKTOP/../
cp -a $WORK_DIR/lubuntu/.icons $NEW_DESKTOP/../

############# �˵�����ʾ��
cp $WORK_DIR/etc/myvim.desktop $ROOTFS/usr/share/applications/myvim.desktop

############# ����
# ͼ��
cp $WORK_DIR/xlock/xlock.desktop $ROOTFS/usr/share/applications/
cp $WORK_DIR/xlock/xlock.desktop $NEW_DESKTOP
#��������
cp $WORK_DIR/xlock/xlock $ROOTFS/usr/sbin
cp $WORK_DIR/xlock/xlockless $ROOTFS/usr/sbin
chmod 777 $ROOTFS/usr/sbin/xlock*

chroot $ROOTFS cp /lib64/ld-linux-x86-64.so.2 /lib/

############# ��ʱ����Ϊ������
chroot $ROOTFS rm /etc/localtime
chroot $ROOTFS ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

############# ����
chroot $ROOTFS apt-get install -y language-pack-zh-hans language-pack-gnome-zh-hans language-pack-zh-hant language-pack-gnome-zh-hant language-pack-en language-pack-gnome-en

############# �����ļ��޸Ĳ���(�����޸Ĺ���mo�ļ�����)
cp $WORK_DIR/i18n/pcmanfm.mo $ROOTFS/usr/share/locale/zh_CN/LC_MESSAGES/pcmanfm.mo

############# ���뷨����װƴ�������
chroot $ROOTFS apt-get install -y fcitx-pinyin fcitx-table-wubi fcitx-table-wbpy 

############# ����������ʾ���������˿�
chroot $ROOTFS apt-get install -y rxvt-unicode

chroot $ROOTFS apt-get clean

# ж�������ع���
# software-properties-gtk �������װ��������������ѡ�����Դ���Ƿ�������
# update-manager �������������ϵͳ��װ����Ҫ����ʱ���������Զ���������
# synaptic�����������������
chroot $ROOTFS apt-get autoremove -y synaptic lubuntu-software-center gdebi software-properties-gtk update-manager

rm -rf $ROOTFS/usr/bin/apt
rm -rf $ROOTFS/usr/bin/apt-get
rm -rf $ROOTFS/usr/bin/dpkg
rm -rf $ROOTFS/usr/bin/dpkg-deb

#chroot $ROOTFS rm -rf $(find /usr -name "*dpkg*") $(find /usr -name "*apt*")
#chroot $ROOTFS rm -rf $(find /etc -name "*dpkg*") $(find /etc -name "*apt*")
