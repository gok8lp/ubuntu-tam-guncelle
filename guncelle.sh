#!/bin/bash
# Ubuntu'yu tek komutla tamamen günceller: apt paketleri, snap ve flatpak uygulamaları, artık paketler.
# Kullanım: ./guncelle.sh
set -e
export DEBIAN_FRONTEND=noninteractive

baslik() { echo; echo "==> $1"; }

baslik "apt: paket listeleri"
sudo apt-get update

baslik "apt: tüm paketler (çekirdek dahil)"
# Değiştirdiğin yapılandırma dosyaları korunur, yenileri .dpkg-dist olarak yanına yazılır
sudo -E apt-get -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold full-upgrade

baslik "apt: artık paketler ve önbellek"
sudo apt-get -y autoremove --purge
sudo apt-get -y autoclean

if command -v snap >/dev/null; then
    baslik "snap"
    sudo snap refresh
fi

if command -v flatpak >/dev/null; then
    baslik "flatpak"
    flatpak update -y
    flatpak uninstall -y --unused
fi

if command -v fwupdmgr >/dev/null; then
    baslik "aygıt yazılımı (yalnızca kontrol)"
    fwupdmgr refresh --force >/dev/null 2>&1 || true
    fwupdmgr get-updates 2>/dev/null || echo "Aygıt yazılımı güncellemesi yok."
fi

echo
if [ -f /var/run/reboot-required ]; then
    echo "Güncelleme tamam. Yeniden başlatma gerekiyor:"
    sed 's/^/  /' /var/run/reboot-required.pkgs 2>/dev/null | sort -u
else
    echo "Güncelleme tamam. Yeniden başlatma gerekmiyor."
fi
