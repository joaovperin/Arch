Load the keyboard mapping. For my kbd, the command is:

  loadkeys br-abnt2

Connect to the internet!

  rfkill unblock wifi
  wifi-menu
  ping 8.8.8.8            -> to test :D

Configure system clock to local time:

  hwclock --systohc
  timedatectl set-ntp true
  timedatectl set-local-rtc 1
  timedatectl set-timezone America/Sao_Paulo
  
https://wiki.archlinux.org/index.php/System_time

Create the partitions!

  fdisk /dev/sda          -> /root, /boot and /home

List the partitions:

  fdisk -l
  
Format and mount the partitions:

  mkfs.vfat /dev/sda1        -> Boot partition
  mkfs.ext4 /dev/sda2        -> Data partitions
  mkfs.ext4 /dev/sda3        -> Data partitions

  mkdir /mnt/boot /mnt/home

  mount /dev/sda2 /mnt
  mount /dev/sda1 /mnt/boot
  mount /dev/sda3 /mnt/home

Install arch base packages

  pacstrap /mnt base base-devel vim dialog
  
Now you can login into vm:
  
  arch-chroot /mnt
  
  
...TO BE CONTINUED.
  

GRAPHICAL UI:

pacman -Syyu
pacman -S xorg xorg-server deepin deepin-extra

FOR VIRTUALBOX:

pacman -S virtualbox virtualbox-guest-utils
systemctl enable vboxservice

sudo pacman -S lightdm-deepin-greeter
sudo pacman -S dbus
systemctl stop dbus
systemctl enable lightdm
reboot now


LINKS: 
https://www.youtube.com/watch?v=SfnsmL72K-g
https://wiki.archlinux.org/index.php/VirtualBox
https://www.howtoforge.com/tutorial/install-arch-linux-on-virtualbox/
https://www.ostechnix.com/install-deepin-desktop-environment-arch-linux/
