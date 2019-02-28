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
  
Once it's installed, now generate the fstab to make the mounts persistent:

  genfstab -U /mnt >> /mnt/etc/fstab
  
Now you can login into vm:
  
  arch-chroot /mnt

Create the symlink to sync local time
  
  ln -sf /usr/share/zoneinfo/Brazil/West /etc/localtime
  
Synchronize system clock to machine's:

  hwclock --systohc
  
Configure locale. Run

  vim /etc/locale.gen
  
...and uncomment following lines:

  en_US.UTF-8 UTF-8
  en_US.ISO8859-1
  pt_BR.UTF-8 UTF-8
  pt_BR.ISO8859-1
  
Generate locale configs:

  locale-gen

Edit the system language and keyboard layout (make persistent):

  echo LANG=pt_BR.UTF-8  > /etc/locale.conf
  echo KEYMAP=br-abnt2  > /etc/vconsole.conf
  
Configure hostname and hosts file:

  echo perin-archvm > /etc/hostname
  echo 127.0.0.1	localhost >> /etc/hosts
  echo ::1        localhost >> /etc/hosts  
  echo 127.0.1.1  perin-archvm.localdomain perin-archvm >> /etc/hosts    
  

Build system image for boot

  mkinitcpio -p linux
  
Set root password

  passwd
  
(Optional) Create new users

  user add [...]
  
Install boot loader:

too many options... you can use grub, grub2, refind...
  
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
