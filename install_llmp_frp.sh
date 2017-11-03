﻿#!/bin/sh

echo -e "#======================================================================
#  仅测试小米路由R1D
#  除R1D外其他路由暂不支持，强制安装后果自负
#  全程只能输入y执行，如果输入n则直接退出，既安装失败
#  Description: llmp+frp+kodexplorer一键安装
#  Version: 1.0.3
#  Author: David
#  web: http://91en.xyz/miwifi
#======================================================================"

echo "您确认要安装吗？请输入y/n"
read
[ "$REPLY" = "y" -o "$REPLY" = "Y" ] || { echo "退出安装..."; exit; }

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> 正在安装llmp请稍后 >>>>>>>>>>>>>>>>>>>>>>>>>>"
wget http://91en.xyz/miwifi/llmp_install.bin -O /tmp/llmp_install.bin
chmod +x /tmp/llmp_install.bin && /tmp/llmp_install.bin in

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> 正在安装frp请稍候 >>>>>>>>>>>>>>>>>>>>>>>>>>"
wget http://91en.xyz/miwifi/frp_0.9.3_linux_arm.tar.gz -O /tmp/frp_0.9.3_linux_arm.tar.gz
chmod +x /tmp/frp_0.9.3_linux_arm.tar.gz
tar -zxvf /tmp/frp_0.9.3_linux_arm.tar.gz -C /userdisk
cd /userdisk
mv frp_0.9.3_linux_arm frpc

echo -e "\033[33m #============================配置frpc.ini==============================
#  1、请手动配置frpc.ini
#  2、将local_ip = 192.168.xx.x改为自己的IP
#  3、将custom_domains = xxx.xx.xx改为已经解析的域名
#  4、默认端口为local_port = 8080可不用更改
#  5、按i键进入修改，完成后按Esc键，再输入:wq回车保存
#  6、这里提供2个免费frp服务商，默认为frp1.chuantou.org
#  server_addr = frp1.chuantou.org   or     frp.lu8.win
#  privilege_token = www.xxorg.com   or     frp888
#========================配置过程可随时向上翻阅======================== \033[0m \n"
echo -e "\033[35m 请认真阅读以上内容，继续配置吗？请输入y/n \033[0m \n"
read
[ "$REPLY" = "y" -o "$REPLY" = "Y" ] || { echo "退出安装..."; exit; }

echo -e "\033[33m 再次确认您已经阅读以上内容，继续配置吗？请输入y/n \033[0m \n"
read
[ "$REPLY" = "y" -o "$REPLY" = "Y" ] || { echo "退出安装..."; exit; }
wget http://91en.xyz/miwifi/frpc.ini -O /userdisk/frpc/frpc.ini
vi /userdisk/frpc/frpc.ini
cd /userdisk/frpc/ && nohup ./frpc -c ./frpc.ini &

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> frpc.ini配置完成 >>>>>>>>>>>>>>>>>>>>>>>>>>"

sleep 1s

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> 添加服务随路由自启动 >>>>>>>>>>>>>>>>>>>>>>>>>>"
chmod +x /etc/rc.local
wget http://91en.xyz/miwifi/rc.local -O /etc/rc.local

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> 正在安装kodexplorer >>>>>>>>>>>>>>>>>>>>>>>>>>"
wget http://91en.xyz/miwifi/kodexplorer.zip -O /tmp/kodexplorer.zip
cd /tmp
unzip /tmp/kodexplorer.zip -d /userdisk/data/wwwroot

echo -e "\033[32m #======================================================================
#  安装完成（脚本没有自动检测是否安装成功，请手动检测）
#  安装成功可用“域名”或“ip:8080”访问站点
#  无法访问请检查frpc.ini的配置
#  安装过程无法下载可能是服务站点无法访问，可能需要翻墙
#  安装失败请手动下载安装，工具和教程都在下面提供的链接里
#  请复制下载地址：https://pan.baidu.com/s/1pLV07xT  密码:ndwu
#  或访问Github:https://github.com/wo20ljj/miwifi
#====================================================================== \033[0m \n"

rm -rf /tmp/install_llmp_frp.sh
rm -rf /tmp/frp_0.9.3_linux_arm.tar.gz
rm -rf /tmp/llmp_install.bin
rm -rf /tmp/kodexplorer.zip

