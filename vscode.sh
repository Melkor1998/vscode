#!/bin/bash

cat > install.sh << done
#!/bin/bash
if [[ \$(which dpkg &> /dev/null && echo '1') == '1' ]]; then
	which wget &> /dev/null || sudo apt-get install wget gpg
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg
	sudo apt install apt-transport-https -y
	sudo apt update
	sudo apt install code -y
	code
elif [[ \$(which yum &> /dev/null && echo '1') == '1' ]]; then
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	yum check-update
	sudo yum install code -y
	code
elif [[ \$(which dnf &> /dev/null && echo '1') == '1' ]]; then
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	dnf check-update
	sudo dnf install code -y
	code
fi
rm -rf install.sh
clear
echo -e "\e[5mThank you for using my Script!\nAuthor: Shota from ITVET group 67\e[0m"
done
chmod +x install.sh
gnome-terminal -x sh -c "./install.sh; bash"
