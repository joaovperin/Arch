Load the keyboard mapping. For my kbd, the command is:

  loadkeys br-abnt2

Create the partitions!

  fdisk /dev/sda          -> /root, /boot and /home

List the partitions:

  fdisk -l
  
Format and mount the partitions:

mkfs.vfat /dev/sda1        -> Boot partition
mkfs.ext4 /dev/sdaX        -> Data partitions

mkdir /mnt /mnt/boot /mnt/home

mount /dev/sdaX /mnt
mount /dev/sda1 /mnt/boot
mount /dev/sda2 /mnt/home

...
pacstrap /mnt base base-devel vim dialog

GRAPHICAL UI:

pacman -Syyu
pacman -S xorg xorg-server deepin deepin-extra

FOR VIRTUALBOX:

pacman -S virtualbox virtualbox-guest-utils
systemctl enable vboxservice

sudo pacman -S lightdm-deepin-greeter


LINKS: 
https://www.youtube.com/watch?v=SfnsmL72K-g
https://wiki.archlinux.org/index.php/VirtualBox
https://www.howtoforge.com/tutorial/install-arch-linux-on-virtualbox/
https://www.ostechnix.com/install-deepin-desktop-environment-arch-linux/
