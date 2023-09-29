#!/bin/bash
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt update -y
sudo apt install openjdk-17-jre-headless -y
sudo ufw allow 25565
sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft
# sudo su - minecraft
mkdir -p /opt/minecraft/{backups,tools,server}
# cd ~/tools && git clone https://github.com/Tiiffi/mcrcon.git
# cd ~/tools/mcrcon
# gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c
cd /opt/minecraft/server
wget https://piston-data.mojang.com/v1/objects/5b868151bd02b41319f54c8d4061b8cae84e665c/server.jar -O minecraft_server.1.20.2.jar
java -Xms1024M -Xmx1024M -jar minecraft_server.1.20.2.jar nogui
head -n -1 eula.txt > eula1.txt
echo "eula=true" >> eula1.txt
rm eula.txt
mv eula1.txt eula.txt
echo "[Unit]

Description=Minecraft Server

After=network.target

[Service]

User=minecraft

Nice=1

KillMode=none

SuccessExitStatus=0 1

ProtectHome=true

ProtectSystem=full

PrivateDevices=true

NoNewPrivileges=true

WorkingDirectory=/opt/minecraft/server

ExecStart=/usr/bin/java -Xmx4G -Xms1024M -jar minecraft_server.1.20.2.jar nogui

[Install]

WantedBy=multi-user.target" > /etc/systemd/system/minecraft.service
sudo chown minecraft:minecraft /opt/minecraft/*
systemctl start minecraft
systemctl enable minecraft
