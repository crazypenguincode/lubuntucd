# lubuntucd -- Customize Live CD for Lubuntu(16.04.3 64 bit)  

## Document  
* [customize the lubuntu live cd(chineses only)](livecd_customize.md)  
* [soft install for the lubuntu(chineses only)](softinstalling.md) 

## Directory/File/Script  
* 1_tar_iso.sh��unpack iso  
* 2_tar_splash.sh:unpack initrd and bootlogo  
* 3_build_splash.sh:make initrd and bootlogo  
* 4_build_iso.sh��make iso  
* update.sh��update logo and other files  
* tools: the tools file directory  
* work: workspace directory(picture, configuration file, etc)  

## Usage

0. clone the project to some directory of Linux system(call it "project directory"). Make sure all .sh script files are executable: chmod +x *.sh. 
1. download lubuntu-16.04.3-desktop-amd64.iso(https://lubuntu.net/downloads/) to the project directory.
2. download firefox-38.0.tar.bz2(http://releases.mozilla.org/pub/firefox/releases/38.0/linux-x86_64/zh-CN/firefox-38.0.tar.bz2) to the tools directory.
3. run: ./1_tar_iso.sh && ./2_tar_splash.sh && ./3_build_splash.sh && ./update.sh  && ./4_build_iso.sh   
 

## Test  
Testing the iso file using the following ways:  
* vmware: create the vmware, use THE iso file to check the result.
* USB flash drive(U-disk): use dd command to burn the iso to USB flash drive(dd if=mylubuntu.iso of=/dev/my-u-disk).

## Author  
Late Lee <li@latelee.org>  
  
## Donate  
[Donate the author](http://www.latelee.org/donate) <br>  
ETH: 0xe3725f50d7E79babae5F5390C85687bc75d0B5FC <br>  
ZEC: t1UUprgPWTeMy1AgmKkNpXXcUZPLL3cxv8U <br>  
  
# lubuntucd -- ����Lubunt(16.04.3 64λ) Live CD  

## �ĵ�  
* [�����ĵ�(���İ�)](livecd_customize.md)  
* [�����װ�ĵ�(���İ�)](softinstalling.md) 

## ������  
* ���汳��ͼƬ OK  
* ϵͳ�����ػ�ͼƬ OK  
* �������֡�ͼƬ OK  
* �ն�Ч�� OK  
* ����ͼ�꼰���� OK  
* HOMEĿ¼�ŵ����� OK  
* ���⡢�����ʽ OK ��ʵ�ַ���������ѵģ�  
* ʱ���޸� OK  
* ���������޸� OK  
* ϵͳ���� OK  
* ƴ����������뷨 OK  
* ɾ�������װ;�� OK  
* �����װ OK �����ڸ��ӣ������ĵ�������  
* �����ļ��޸� OK  
* ���� OK  
* �˵����ࡢ���� OK  
* ����ͼ����� NOOOOO  
  
## ��������  
* ����ͼ�� ��װlubuntu 16.04 ����Ϊ ��װϵͳ  
* ɾ��������ġ������á����������  
* ж��Ĭ�ϵ�firefox����װfirefox38�汾������������ѹ������  
* ����ʹ��xlock����Ҫ��װ�����������Ҫ�޸����ӿ�Ŀ¼��  
* ���԰�ֻ���Ӣ�ġ��������ġ�����������������  

## Ŀ¼/�ļ�/�ű�˵��  
* 1_tar_iso.sh����ѹiso  
* 2_tar_splash.sh:��ѹinitrd��bootlogo  
* 3_build_splash.sh:��������initrd��bootlogo  
* 4_build_iso.sh������iso  
* update.sh�����������ļ���ͼƬ�ȡ�  

## �÷�
0. ���ر����ֿ̲⵽Linuxĳ��Ŀ¼��������Ŀ¼������ȷ������.sh�ļ��п�ִ�����ԡ������ִ�����chmod +x *.sh��
1. ����lubuntu-16.04.3-desktop-amd64.iso(https://lubuntu.net/downloads/) ������Ŀ¼
2. ����firefox-38.0.tar.bz2(http://releases.mozilla.org/pub/firefox/releases/38.0/linux-x86_64/zh-CN/firefox-38.0.tar.bz2) ������Ŀ¼��toolsĿ¼
3. ִ�У�./1_tar_iso.sh && ./2_tar_splash.sh && ./3_build_splash.sh && ./update.sh  && ./4_build_iso.sh   

## ����  
ʹ������2�ַ������ԣ�
* vmware������vmware�������ֱ��ʹ�����ɵ�ISO�����������鿴Ч����
* U����¼��ʹ��dd������дISO����U�̣�Ȼ���ڼ��������֮(���dd if=mylubuntu.iso of=/dev/U���豸�ļ�)��
  
## ����  
��� <li@latelee.org>  
  
## ����  
����Ը����а�������ӭ������  
[��������](http://www.latelee.org/donate)  
���ֱң� <br>  
ETH: 0xe3725f50d7E79babae5F5390C85687bc75d0B5FC  
ZEC: t1UUprgPWTeMy1AgmKkNpXXcUZPLL3cxv8U  
  
  