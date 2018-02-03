#!/bin/bash
# Author��Late Lee<li@latelee.org>
# �÷���./4_build_iso.sh
# ���ű�������Ŀ¼iso��ִ�У�isoĿ¼��newiso��squashfs-rootĿ¼
# �����ISO_IDR��ROOTFS���뱣����1_tar_iso.sh�ű��е�һ��

# ���̽�ѹ���Ŀ¼
ISO_IDR=$PWD/newiso
# ��ѹsquashfs��Ŀ¼
ROOTFS=$PWD/squashfs-root

# ������ɵľ�������ƣ���������������д���õ�iso����
ISO_NAME=$PWD/lubuntu-16.04.3-desktop-amd64-KXS.iso

# xorriso�����������ļ���������дU��ϵͳ���޷�����
ISOHDPFX_FILE=$PWD/work/isolinux/isohdpfx.bin

#################################################################
# �ָ�resolv.conf��ԭʼֵ
echo "" > $ROOTFS/etc/resolv.conf

# ����myversion�Լ�¼��Ϣ�����ļ�����ɾ��
echo "Lubuntu by Late Lee<li@latelee.org>" > squashfs-root/etc/myversion
date >> squashfs-root/etc/myversion

# ɾ��urandom�ļ�
rm -rf squashfs-root/dev/urandom

# ���������ԭ���ubuntu��wiki��ȡ���������޸�
# >>>>>>>>>>>>>>>>>>>>> ��ʼ
chmod +w $ISO_IDR/casper/filesystem.manifest
# ϵͳ��װ���������Ϣ
# 
cp /usr/bin/dpkg-query $ROOTFS/usr/bin/
chroot $ROOTFS dpkg-query -W --showformat='${Package} ${Version}\n' > $ISO_IDR/casper/filesystem.manifest
cp $ISO_IDR/casper/filesystem.manifest $ISO_IDR/casper/filesystem.manifest-desktop
sed -i '/ubiquity/d' $ISO_IDR/casper/filesystem.manifest-desktop
sed -i '/casper/d' $ISO_IDR/casper/filesystem.manifest-desktop

# ��ʼѹ��
rm -rf  $ISO_IDR/casper/filesystem.squashfs
echo "making squashfs..."
mksquashfs $ROOTFS $ISO_IDR/casper/filesystem.squashfs

# ��ȡ�ļ�ϵͳ��С�����洢�������ļ���
printf $(du -sx --block-size=1 $ROOTFS | cut -f1) > $ISO_IDR/casper/filesystem.size
SIZE=`cat $ISO_IDR/casper/filesystem.size`
echo "we got fs size:"  $SIZE

# ��������md5
echo "making iso..."
cd $ISO_IDR
rm -rf md5sum.txt
find -type f -print0 | xargs -0 md5sum | grep -v isolinux/boot.cat | tee md5sum.txt

# ����iso
# ע��-V�Ǵ��ǩ����˼
#mkisofs -D -r -V "lubuntu-KXS 16.04.3" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../$ISO_NAME .

# ע��ʹ��xorriso������ISO����dd��д��U�̣�������������mkisofs���ɹ���ԭ��δ֪
# ���ǣ���������������������ISO��������vmware����
# ������U������Ϊ��֤��׼
xorriso -as mkisofs \
  -v -R -J -joliet-long -input-charset utf8 \
  -publisher "KXS" -p "Late Lee" -V "lubuntu-KXS 16.04.3" \
  -isohybrid-mbr $ISOHDPFX_FILE \
  -c isolinux/boot.cat -b isolinux/isolinux.bin \
  -no-emul-boot -boot-load-size 4 -boot-info-table \
  -eltorito-alt-boot -e boot/grub/efi.img \
  -no-emul-boot  -isohybrid-gpt-basdat \
  -o $ISO_NAME .

# <<<<<<<<<< ����
