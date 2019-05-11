#!/bin/sh

# Fedberry Installation:
#
# - http://download.fedberry.org/releases/29/images/armhfp/29.1/fedberry-xfce-29.1.raw.xz herunterladen
# - auf Linux, z.B. Fedora, CentOS etc. folgendes Kommando als root ausführen (ACHTUNG: das Gerät sdc
#   wird dabei überschrieben!! Also entsprechend anpassen auf das Gerät, das die SD Karte darstellt!):
#     xzcat <Pfad-zum-Download>/fedberry-xfce-29.1.raw.xz | dd status=progress bs=4M of=/dev/sdc && sync;sync;sync
# - SD Karte in den Raspberry Pi legen, Raspberry Pi starten und Netzwerk, Zeitzone, root Passwort und Benutzer anlegen
# - Installation und Neustart abwarten, dann mit dem angelegten Benutzer einloggen
# - Menü öffnen, unter "Administration" -> "Language" anklicken und "German (Germany) - Deutsch" auswählen -> "Ok"
#   (dauert lange! Warten, bis eine Bestätigungsmeldung erscheint!)
# - Menü öffnen, unter "Administration" -> "Keyboard" anklicken, Benutzerpasswort bestätigen und
#   "German (latin1 w/ no deadkeys)" auswählen, mit der "Tab" Taste auf "Ok" gehen und mit <ENTER> bestätigen
# - Terminal (Konsole) starten und folgendes Kommando eingeben:
#     sudo dnf update -y
#   und mit bei Aufforderung mit Benutzerpasswort bestätigen. Warten, bis alle Updates durchgeführt wurden. Dann
#   das Kommando
#     sudo dnf install -y git hostapd
#   eingeben; danach über das Menü und "Log Out" auf "Restart" klicken. Warten, bis das auf den aktuellen Stand
#   gebrachte System den Benutzerlogin anzeigt; wieder einloggen.
# - Folgendes Kommando eingeben:
#     git clone https://github.com/joschro/it4kids.git
# - nun kann auf die Präsentationen unter it4kids/de/ zugegriffen werden und das Skript zum Installieren der
#   Pi-Hole Software aufgerufen werden:
#     sudo sh it4kids/de/raspberrypi-free-wlan-ap-pihole.sh

test "$(whoami)" == "root" || {
	echo "This script needs to be run as user \"root\"! Please use"
	echo "  sudo sh $0"
	echo "to run this script with proper rights."
	exit
}

git clone https://github.com/oblique/create_ap.git
cd create_ap && make install
# create_ap wlan0 eth0 FreeWifi :
sed -i "s/^CHANNEL=.*/CHANNEL=13/;^SSID=.*/SSID=FreeWifi/;^PASSPHRASE=.*//;^GATEWAY=.*/GATEWAY=192.168.42.1/;s/^NO_DNS=.*/NO_DNS=1/;s/^NO_DNSMASQ=.*/NO_DNSMASQ=1/;s/^NO_VIRT=.*/NO_VIRT=1/;s/^COUNTRY=.*/COUNTRY=DE" /etc/create_ap.conf
systemctl enable create_ap
systemctl start create_ap
# disable SELinux for Pi-Hole (needs to be fixed in Pi-Hole):
sed -i "s/^SELINUX=.*/SELINUX=disabled/" /etc/selinux/config
setenforce 0
# fixes for Pi-Hole:
firewall-cmd --add-service=dhcp --permanent
firewall-cmd --reload
touch /etc/sysconfig/network-scripts/ifcfg-wlan0
echo -e "Im folgenden Dialog bitte einfach immer mit ok, bestätigen, nur beim Interface "wlan0" auswählen und bei Netzwerk auf <Nein> und als "desired IPv4 address"\n  192.168.42.1/24\n und bei "desired IPv4 default gateway"\n  192.168.42.1\n eingeben! Zum Schluss das angezeigte Admin Passwort merken! Mit <ENTER> geht es weiter."
read ANSW
curl -sSL https://install.pi-hole.net | bash
echo "Nach erfolgreicher Installation kann man sich per Browser (als default ist Chromium installiert) auf "http://192.168.42.1/admin" das Pi-Hole Webinterface anschauen."
echo "Bitte mit dem gemerkten Admin Passwort einloggen und im Menü links auf "Settings" gehen und den Reiter "DHCP" oben  auswählen. Nun noch "DHCP Server enabled" aktivieren und ganz rechts unten auf "Save" klicken. Jetzt im Reiter "System" auf "Restart System" klicken und bestätigen."
echo "Done"
