#!/bin/bash
# Author��Late Lee<li@latelee.org>
# �÷���./1_tar.iso.sh xxx.iso
# ���ܣ�
# ��ѹubuntu livecd��iso���õ����е�rootfs
# ���յõ���Ŀ¼��2�����ֱ�Ϊ��
# squashfs-root���ڴ�Ŀ¼chroot������һ��ϵͳ�����԰�װ����������޸ı���ͼƬ���ȵ�
# newiso�������ƶ�iso��Ҫ��Դ�ļ�

# ����Ĭ�ϵ�ԭʼ��������ƣ���ָ��ISO��ʹ�ô��ļ�
ISO_NAME=lubuntu-16.04.3-desktop-amd64.iso

# ��֤��rootȨ��
if [ `whoami` != "root" ];then
    echo "you are not root! try: -s"
    exit
fi

# ����û�����ָ����iso������ʹ��֮
if [ $# -gt 0 ]; then
    echo "will try iso" $1
    ISO_NAME=$1
fi

# �����洢�ļ���Ŀ¼������foo����ʱĿ¼���ἴʱ��ɾ����
mkdir -p foo newiso
mount $ISO_NAME foo/ -o loop
cp  -a  foo/* newiso/
cp -av foo/.disk newiso/
umount foo/
rm -rf foo/

# ����newiso�������е�ѹ���ļ�ϵͳ��ѹ
cd newiso
unsquashfs casper/filesystem.squashfs
mv squashfs-root ../ # �����Ƶ�����Ŀ¼
cd ..

# ע�����ｫ������resolv.conf�������µ��ļ�ϵͳĿ¼�У�
# ����chroot�󣬾Ϳ���ʹ�������ˡ�
# ��Ȼ��ǰ����������resolv.conf�������������ġ�
cp /etc/resolv.conf  squashfs-root/etc

# �����δ���ԣ���ע�͵�
#chroot  squashfs-root
#mount none  /proc -t  proc # ��������
#mknod /dev/urandom c 1 9

