# Ubuntu Tam Güncelleme

Ubuntu'yu tek komutla baştan sona günceller.

## Kullanım

```bash
git clone https://github.com/gok8lp/ubuntu-tam-guncelle.git && cd ubuntu-tam-guncelle
./guncelle.sh
```

`sudo` parolası bir kez sorulur.

## Ne yapar

| Adım | Komut |
| --- | --- |
| Paket listelerini yeniler | `apt-get update` |
| Tüm paketleri yükseltir (çekirdek dahil) | `apt-get full-upgrade` |
| Artık paketleri ve eski önbelleği temizler | `apt-get autoremove --purge`, `autoclean` |
| Snap uygulamalarını günceller | `snap refresh` |
| Flatpak uygulamalarını günceller, kullanılmayanları siler | `flatpak update`, `flatpak uninstall --unused` |
| Aygıt yazılımı güncellemelerini listeler (kurmaz) | `fwupdmgr get-updates` |

Sonunda yeniden başlatma gerekip gerekmediğini ve hangi paketlerin istediğini söyler.

## Güvenlik notları

- Senin değiştirdiğin yapılandırma dosyaları korunur (`--force-confold`); paketin yeni sürümü yanına `.dpkg-dist` olarak yazılır.
- Aygıt yazılımı (BIOS vb.) otomatik kurulmaz, yalnızca listelenir. Kurmak için: `fwupdmgr update`.

## Lisans

[MIT](LICENSE)
