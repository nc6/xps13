# Notes on installing NixOS on Dell XPS-13 Late 2016 9360
# Build a NixOS bootable USB stick Via RUFUS and NixOS image

# Boot from the usb.
# F12 to enter boot menu

# Set UK keymap
loadkeys uk

# Set large font
setfont latarcyrheb-sun32

# Create two partitions:
# 1 512MB EFI partition # Hex code ef00 called "boot"
# 2 100% Linux partiton (to be encrypted) # Hex code 8300 called "linux"
cgdisk /dev/nvme0n1

# Setup the encryption of the system
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup luksOpen /dev/nvme0n1p2 enc-pv

# Create LVM partitions
pvcreate /dev/mapper/enc-pv
vgcreate vg0 /dev/mapper/enc-pv
lvcreate -L 16G -n swap vg0
lvcreate -l '100%FREE' -n nixos vg0

# Format
mkfs.fat /dev/nvme0n1p1
mkfs.ext4 -L nixos /dev/vg0/nixos
mkswap -L swap /dev/vg0/swap

mount /dev/vg0/nixos /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
swapon /dev/vg0/swap

nixos-generate-config

# change /etc/nixos/configuration.nix
# DO NOT networking.wireless.enable = true, we'll
# use NetworkManager with gnome3 instead


# Networking
## Wifi is a bit of bugger, but restarting network-manager and using nmcli seems to help
nmcli dev
nmcli dev wifi list
nmcli dev wifi con "myssid" password "myssidpassword"

nixos-install

# If you screw up and need to reboot

cryptsetup luksOpen /dev/nvme0n1p2 enc-pv
lvchange -a y /dev/vg0/swap
lvchange -a y /dev/vg0/root
mount /dev/vg/root /mnt
mount /dev/nvme0n1p1 /mnt/boot
swapon /dev/vg0/swap

nixos-generate-config

# Also see

https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134

# Notes
# Bit of a pity that NixOS isnt using wayland yet, HiDPI is a bit of a bugger, but
# gsettings set org.gnome.desktop.interface scaling-factor 2
# from the command line helps
#
# Had to manually install /etc/ssl/certs/AddTrust_External_CA_Root_DER_X.509.cer
# to get eduroam to work, but this is probably in a package somewhere?
#
