#!/bin/sh

# https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers
# https://docs.fedoraproject.org/quick-docs/en-US/creating-windows-virtual-machines-using-virtio-drivers.html

stable=$(curl -LIs -o /dev/null -w "%{url_effective}" https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso)
latest=$(curl -LIs -o /dev/null -w "%{url_effective}" https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso)

stable_version=$(echo "$stable" | grep -o "[0-9.]*.iso$" | sed "s/.iso$//")
latest_version=$(echo "$latest" | grep -o "[0-9.]*.iso$" | sed "s/.iso$//")

last_version=$(cat "$(dirname "$0")/.downloaded-qemu-guest-agent.log")

echo "qemu guest agent"
echo "last checked version: $last_version"
echo "newest stable version: $stable_version"
echo "newest latest version: $latest_version"
