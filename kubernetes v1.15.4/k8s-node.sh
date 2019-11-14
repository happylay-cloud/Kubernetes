#!/bin/bash
#-----------------------------------------------Kubernetes v1.15.4-node节点安装-----------------------------------------------
#-----------------------------------------------------手动输入----------------------------------------------------------------
read -p "1.设置节点名称,默认【k8s-node-1】：" sethostname
read -p "2.设置master-ip地址,默认【172.17.16.9】：" masterip
read -p "3.设置master-dns名称,默认【apiserver.k8s】：" apiservername
read -p "4.设置pod容器所在网段,默认【10.100.0.1/20】：" podsubnet

#-----------------------------------------------------------------------------------------------------------------------------
# 设置节点名称
# sethostname='k8s-node-1'
# 设置master-ip地址
# masterip='172.17.16.9'
# 设置master-dns名称
# apiservername='apiserver.k8s'
# 设置pod容器所在网段
# podsubnet='10.100.0.1/20'

#-----------------------------------------------------------------------------------------------------------------------------
# 修改 hostname
hostnamectl set-hostname $sethostname
# 查看修改结果
hostnamectl status
# 设置 hostname 解析
echo "127.0.0.1   $(hostname)" >> /etc/hosts
#-----------------------------------------------------------------------------------------------------------------------------
# 安装 docker / kubelet
# 在 master 节点和 worker 节点都要执行
curl -sSL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/install-script/install-kubelet.sh | sh

#-----------------------------------------------------------------------------------------------------------------------------
# 只在 worker 节点执行
# 替换 x.x.x.x 为 master 节点的内网 IP
export MASTER_IP=$masterip
# 替换 apiserver.demo 为初始化 master 节点时所使用的 APISERVER_NAME
export APISERVER_NAME=$apiservername
echo "${MASTER_IP}    ${APISERVER_NAME}" >> /etc/hosts

#-----------------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------------
echo "
# 替换为 master 节点上 kubeadm token create 命令的输出
kubeadm join $apiservername:6443 --token mpfjma.4vjjg8flqihor4vt  --discovery-token-ca-cert-hash sha256:6f7a8e40a810323672de5eee6f4d19aa2dbdb38411845a1bf5dd63485c43d303
"
#-----------------------------------------------------------------------------------------------------------------------------