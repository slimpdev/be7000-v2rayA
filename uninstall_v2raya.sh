#!/bin/sh

# Находим первую папку в /mnt/
USB_DIR=$(find /mnt -mindepth 1 -maxdepth 1 -type d | head -n 1)

# Проверяем, что USB-папка найдена
if [ -z "$USB_DIR" ]; then
  echo "USB-папка не найдена в /mnt/"
  exit 1
fi

echo "USB-папка найдена: $USB_DIR"

# Удаление целевых папок
echo "Удаление распакованных папок v2ray и v2raya..."
rm -rf "$USB_DIR/v2rayA-native/v2ray-core"
rm -rf "$USB_DIR/v2rayA-native/v2raya"
rm -rf "$USB_DIR/v2rayA-native/v2ray-geoip"
rm -rf "$USB_DIR/v2rayA-native/v2ray-geosite"

# Удаление исполняемых файлов и данных
echo "Удаление исполняемых файлов и данных из $USB_DIR..."
rm -rf "$USB_DIR/usr/bin/v2ray"
rm -rf "$USB_DIR/usr/bin/v2raya"
rm -rf "$USB_DIR/usr/share/v2ray"
rm -rf "$USB_DIR/usr/share/v2raya"
rm -rf "$USB_DIR/v2raya/config"

# Удаление конфигураций из /data/v2raya
echo "Удаление конфигурационных файлов из /data/v2raya..."
rm -rf /data/v2raya/etc/config/v2ray
rm -rf /data/v2raya/etc/config/v2raya
rm -rf /data/v2raya/etc/init.d/v2ray
rm -rf /data/v2raya/etc/init.d/v2raya

# Удаление скрипта автозапуска
echo "Удаление скрипта автозапуска /data/startup_v2raya.sh..."
rm -f /data/startup_v2raya.sh

# Восстановление бэкапа конфигурации firewall
FIREWALL_CONFIG="/etc/config/firewall"
if [ -f "$FIREWALL_CONFIG.bak" ]; then
  echo "Восстановление оригинального файла конфигурации firewall из бэкапа..."
  mv "$FIREWALL_CONFIG.bak" "$FIREWALL_CONFIG"
else
  echo "Бэкап firewall не найден. Удаление изменений в firewall..."
  
  # Если бэкапа нет, удаляем изменения вручную
  # Удаляем блок с startup_v2raya, если он есть
  sed -i '/config include '\''startup_v2raya'\''/,/option enabled '\''1'\''/d' "$FIREWALL_CONFIG"
fi

# Отключение и остановка сервисов v2ray и v2raya, если они были активированы
echo "Остановка и отключение сервисов v2ray и v2raya..."
/etc/init.d/v2ray stop 2>/dev/null
/etc/init.d/v2ray disable 2>/dev/null
rm -f /etc/init.d/v2ray

/etc/init.d/v2raya stop 2>/dev/null
/etc/init.d/v2raya disable 2>/dev/null
rm -f /etc/init.d/v2raya

# Завершение
echo "Деинсталляция завершена. Все внесенные изменения удалены."
