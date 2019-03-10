Load the keyboard mapping. For my kbd, the command is:

  loadkeys br-abnt2

Connect to the internet!

  rfkill unblock wifi
  wifi-menu
  ping 8.8.8.8            -> to test :D

Configure system clock to local time:

  hwclock --systohc --localtime
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

  pacstrap /mnt base base-devel vim dialog htop

If you're using a BIOS boot (VirtualBOX), run also:

    pacstrap /mnt grub-bios

Once it's installed, now generate the fstab to make the mounts persistent:

  genfstab -U /mnt >> /mnt/etc/fstab

Now you can login into vm:

  arch-chroot /mnt

Create the symlink to sync local time

  rm -rf /etc/localtime
  ln -sf /usr/share/zoneinfo/Brazil/West /etc/localtime

Synchronize system clock to machine's:

  hwclock --systohc --localtime

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
  export LANG=pt_BR.UTF-8
  echo KEYMAP=br-abnt2  > /etc/vconsole.conf
  localectl set-keymap --no-convert br-abnt2

Configure hostname and hosts file:

  echo perin-archvm > /etc/hostname
  echo 127.0.0.1	localhost >> /etc/hosts
  echo ::1        localhost >> /etc/hosts
  echo 127.0.1.1  perin-archvm.localdomain perin-archvm >> /etc/hosts

Install some packages:

    pacman -Sy sshd
    systemctl enable sshd.service

Install boot loader:

too many options... you can use grub, grub2, refind...
Grub:

    grub-install /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg

Set root password

  passwd

(Optional) Create new users

  user add -m -g users -G wheel -s /bin/bash joaovperin
  passwd joaovperin
  vim /etc/sudoers   (or run visudo)  to allow him to invoke sudo privilleges

Build system image for boot

  mkinitcpio -p linux

In order to have network on the new machine, you need to enable dhcpcd service

  pacman -Sy dhcpcd
  systemctl enable dhcpcd
  systemctl enable NetworkManager

NOW THE MACHINE IS READY TO USE, BUT IT DON'T HAVE A GUI.

    exit
    umount -R /mnt
    reboot now

GRAPHICAL UI:

    pacman -Syyu
    pacman -Sy xorg xorg-xinit
    pacman -Sy deepin deepin-extra   (or KDE or I3WM or GNOME or the fucking whatever you want to use as DE. I use Deepin.)

Fonts:

    pacman -Sy ttf-freefont

Install a login manager. I use lightdm:

    pacman -S lightdm lightdm-deepin-greeter (or lightdm-gtk-greeter)
    systemctl enable lightdm.service

Aditional packages (choose what you want)

    pacman -Sy firefox qt4 vlc gimp flashplugin
    pacman -Sy wps-office gedit

FOR VIRTUALBOX:

    pacman -S virtualbox virtualbox-guest-utils
    systemctl enable vboxservice


sudo pacman -S lightdm-deepin-greeter
sudo pacman -S dbus
systemctl stop dbus
systemctl enable lightdm
reboot now

IF YOU DID EVERYTHING OKAY, YOUR SYSTEM IS NOW READY TO BE USED :D

STEAM:
You have to use AUR. I'm using yay as an aur-helper:
https://github.com/Jguer/yay

  yay -S steam steam-fonts ttf-ms-fonts
  yay -S wine playonlinux gecko wine-mono

LINKS:
https://www.youtube.com/watch?v=SfnsmL72K-g
https://wiki.archlinux.org/index.php/VirtualBox
https://www.howtoforge.com/tutorial/install-arch-linux-on-virtualbox/
https://www.ostechnix.com/install-deepin-desktop-environment-arch-linux/
