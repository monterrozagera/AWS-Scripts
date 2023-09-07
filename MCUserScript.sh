mkdir -p ~/{backups,tools,server}
# cd ~/tools && git clone https://github.com/Tiiffi/mcrcon.git
# cd ~/tools/mcrcon
# gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c
cd ~/server
wget https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar -O minecraft_server.1.20.1.jar
sudo java -Xms1024M -Xmx1024M -jar minecraft_server.1.20.1.jar nogui
head -n -1 eula.txt > eula1.txt
echo "eula=true" >> eula1.txt
rm eula.txt
mv eula1.txt eula.txt
sudo echo "[Unit]

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

ExecStart=/usr/bin/java -Xmx4G -Xms1024M -jar minecraft_server.1.20.1.jar nogui

[Install]

WantedBy=multi-user.target" > /etc/systemd/system/minecraft.service
sudo systemctl start minecraft
sudo systemctl enable minecraft
