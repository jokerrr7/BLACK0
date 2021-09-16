#!/usr/bin/env bash 
cd $(cd $(dirname $0); pwd)
Day_now=$(date +%F)
RED='\033[0;31m'
SMAY='\033[0;36m'
GREEN='\033[0;32m'
Yellow='\033[0;33m'
LSAMAY='\033[01;49m'
WHITB='\033[01;90m'
WHITEC='\033[01;91m'
CNIL='\033[0m'

Version=`lsb_release -rs | cut -f1 -d"."`
memory_free=`awk '/^Mem/ {print $4}' <(free -m)`

if [ "$memory_free" -le 60 ]; then
echo -e "${RED}¦
¦ CAUTION:${WHITEC} Your RAM size is less than 60MB.
¦ NOW you can not install the SOURCE MAX. \n
¦${WHITB}¦ YOUR RAM FREE SIZE IS : ${SMAY}${memory_free}MB${CNIL}"
exit ;
fi


PKG_OK=`/usr/bin/dpkg-query --show --showformat='${db:Status-Status}\n' 'redis-server'`
if [ "${PKG_OK}" == "installed" ]; then
if [ "$1" == "-R" ] ; then
GET_INSTALL="NO"
else
GET_INSTALL=$(redis-cli get TEAMTELETHON_INSTALL)
fi
if [ "${GET_INSTALL}" == "Yes" ]; then
echo -e "
${SMAY}>> ${LSAMAY}Source TEAMTELETHON${SMAY} is Already Installed ^_^ .\n${CNIL}"
sudo luarocks install luautf8
sudo chmod +x ./tg
sudo chmod +x ./on
sudo ./on
exit;
fi 
fi

echo -e "${WHITB}\n¦ installing source ... \n\n\n\n${CNIL}"
sudo apt-get update -y
sudo apt-get upgrade -y
echo -e "\x1B[01;90m\n¦ software-properties-common installing ... \n\x1B[0m"
sudo apt-get install software-properties-common -y
echo -e "\x1B[01;90m\n¦ ubuntu-toolchain installing ...\n \x1B[0m"
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
# BY _ [ MAX >> @Hskh56 | KAIDO >> @uop70 ]
echo -e "\x1B[01;90m\n¦ install luarocks v2.4.3 ... \n\x1B[0m"
sudo  wget https://luarocks.org/releases/luarocks-2.4.3.tar.gz
sudo  tar zxpf luarocks-2.4.3.tar.gz
cd luarocks-2.4.3
echo -e "\x1B[01;90m\n¦ ./configure AND make bootstrap ...\n \x1B[0m"
./configure; sudo make bootstrap
sudo luarocks install luasocket
echo -e "\x1B[01;90m\n¦ luasocket installing ...\n \x1B[0m"
sudo luarocks install luasec
sudo luarocks install luautf8
echo -e "\x1B[01;90m\n¦ redis-lua installing ... \n\x1B[0m"
sudo luarocks install redis-lua
echo -e "\x1B[01;90m\n¦ lua-cjson installing ... \n\x1B[0m"
sudo  luarocks remove lua-cjson2
sudo  luarocks remove lua-cjson
sudo  apt-get install lua-cjson
echo -e "\x1B[01;90m\n¦ Lua-cURL installing ...\n \x1B[0m"
sudo luarocks install Lua-cURL
echo -e "\x1B[01;90m\n¦ redis-server start ...\n \x1B[0m"
sudo service redis-server start
sudo apt-get update -y
echo -e "\x1B[01;90m\n¦  g++-4.7 -y c++-4.7 installing ... \n\x1B[0m"
sudo apt-get install g++-4.7 -y c++-4.7
echo -e "\x1B[01;90m\n¦ luasocket installing ...\n \x1B[0m"
sudo apt-get install libreadline-dev -y libconfig-dev -y libssl-dev -y lua5.2 -y liblua5.2-dev -y lua-socket -y lua-sec -y lua-expat -y libevent-dev -y make unzip git redis-server autoconf g++ -y libjansson-dev -y libpython-dev -y expat libexpat1-dev -y curl -y htop -y
echo -e "\x1B[01;90m\n¦ screen installing ... \n\x1B[0m"
sudo apt-get install screen -y
echo -e "\x1B[01;90m\n¦ libstdc++6 installing ... \n\x1B[0m"
sudo apt-get install libstdc++6 -y
echo -e "\x1B[01;90m\n¦ lua-lgi installing ... \n\x1B[0m"
sudo apt-get install lua-lgi -y
echo -e "\x1B[01;90m\n¦ libnotify installing ... \n\x1B[0m"
sudo apt-get install libnotify-dev -y
cd ..
echo -e "\x1B[01;90m\n¦ Remove luarocks ... \n\x1B[0m"
sudo rm -fr ./luarocks-2.4.3
sudo rm -fr ./luarocks-2.4.3.tar.gz
echo -e "${WHITB}\n¦ Convert TimeZone To Asia/Baghdad  ... \n${CNIL}"
sudo timedatectl set-timezone Asia/Baghdad
if [ "$Version" == "18" ];then
  echo -e "${WHITB}\n¦ Installing depedencies for ubuntu 18  ... \n${CNIL}"
  cd /lib/x86_64-linux-gnu/ && sudo ln -s libreadline.so.7.0 libreadline.so.6
  wget "ibotcorp.com/files/compat-libevent2-5_2.0.21-1ubuntu18_amd64.deb" && sudo dpkg -i compat-libevent2-5_2.0.21-1ubuntu18_amd64.deb
  rm compat-libevent2-5_2.0.21-1ubuntu18_amd64.deb
fi
redis-cli set TEAMTELETHON_INSTALL YES
cd && cd TEAMTELETHON
sudo chmod +x ./tg
echo -e "\n
${SMAY}>> Installation ${LSAMAY}Source TEAMTELETHON${SMAY} Completed ^_^ .\n"
sudo chmod +x ./FastBLACK.sh
./FastBLACK.sh
