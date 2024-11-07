# be7000-v2rayA

## Скрипт в разработке, пока не работают днс.
## Если вы можете помочь с доработкой - напишите в Issues, или создайте Pull request, спасибо.

Работает так: 
1. В корне вашей флешки (/mnt/usb-ВАШИ_ЦИФРЫ/) создаете папку v2rayA-native.
2. В ней папку ipk_files, в неё кладете файлы:
   - v2raya_2.2.5.7-1_aarch64_generic.ipk
   - v2ray-core_5.18.0-1_aarch64_generic.ipk
   - v2ray-geoip_202410030052-1_all.ipk
   - v2ray-geosite_20240920063125-1_all.ipk

их можно взять здесь - https://downloads.openwrt.org/releases/23.05.0/packages/aarch64_generic/packages/

3. Скрипты install_v2raya.sh и uninstall_v2raya.sh копируете в /data/ , делаете им chmod +x
4. Запускаете /data/install_v2raya.sh
5. Для удаления - соответственно /data/uninstall_v2raya.sh
