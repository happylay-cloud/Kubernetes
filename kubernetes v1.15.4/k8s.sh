#!/bin/bash
#-------------------------------------------使用kubeadm安装kubernetes_v1.15.4-master管理者---------------------------------
#-----------------------------------------------------手动输入------------------------------------------------

# 设置master主节点名称
sethostname="$1"
# 设置master-ip地址
setmasterip="$2"
# 设置master-dns名称
apiservername="$3"
# 设置pod容器所在网段
podsubnet="$4"

# 暂时不能输入
# read -p "1.设置master名称,默认【k8s-master】：" sethostname
# read -p "2.设置master-ip地址,默认【172.17.16.9】：" setmasterip
# read -p "3.设置master-dns名称,默认【apiserver.k8s】：" apiservername
# read -p "4.设置pod容器所在网段,默认【10.100.0.1/20】：" podsubnet

#------------------------------------------------------------------------------------------------------------
# 设置主机hostname
# sethostname='k8s-master'
# 设置主机内网ip
# setmasterip='172.17.16.9'
# 设置dns名称
# apiservername='apiserver.k8s'
# 设置容器网段
# podsubnet='10.100.0.1/20'

#------------------------------------------------------------------------------------------------------------
#-------------------------------------------修改 hostname-----------------------------------------------------
# 修改 hostname
hostnamectl set-hostname $sethostname
# 查看修改结果
hostnamectl status
# 设置 hostname 解析
echo "127.0.0.1   $(hostname)" >> /etc/hosts
#------------------------------------------------------------------------------------------------------------
# 安装docker及kubelet
# 在 master 节点和 worker 节点都要执行

ret=`curl -s  https://api.ip.sb/geoip | grep China | wc -l`
if [ $ret -ne 0 ]; then
   curl -sSL https://gitee.com/happylay/Kubernetes/raw/master/kubernetes%20v1.15.4/install-script/install-kubelet.sh | sh
else
   curl -sSL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/install-script/install-kubelet.sh | sh
fi; 
#------------------------------------------------------------------------------------------------------------
#-------------------------------------------初始化 master 节点------------------------------------------------
# 只在 master 节点执行
# 替换 x.x.x.x 为 master 节点实际 IP（请使用内网 IP）
# export 命令只在当前 shell 会话中有效，开启新的 shell 窗口后，如果要继续安装过程，请重新执行此处的 export 命令

echo "MASTER_IP=$setmasterip" >>  /etc/profile

# 替换 apiserver.demo 为 您想要的 dnsName

echo "APISERVER_NAME=$apiservername" >>  /etc/profile

# Kubernetes 容器组所在的网段，该网段安装完成后，由 kubernetes 创建，事先并不存在于您的物理网络中

echo "POD_SUBNET=$podsubnet" >>  /etc/profile

source /etc/profile

echo "${MASTER_IP}    ${APISERVER_NAME}" >> /etc/hosts

if [ $ret -ne 0 ]; then
   curl -sSL https://gitee.com/happylay/Kubernetes/raw/master/kubernetes%20v1.15.4/install-script/init_master.sh | sh
else
   curl -sSL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/install-script/init_master.sh | sh
fi;
#------------------------------------------------------------------------------------------------------------
#-------------------------------------------检查 master 初始化结果--------------------------------------------
# 只在 master 节点执行

# 执行如下命令，等待 3-10 分钟，直到所有的容器组处于 Running 状态-不执行
# watch kubectl get pod -n kube-system -o wide

# 查看 master 节点初始化结果
kubectl get nodes -o wide

#------------------------------------------------------------------------------------------------------------
#-------------------------------------------初始化 worker节点-------------------------------------------------
# 获得 join命令参数
# 只在 master 节点执行
kubeadm token create --print-join-command >> ./k8s-join-token.txt

echo '
有效时间
该 token 的有效时间为 2 个小时，2小时内，您可以使用此 token 初始化任意数量的 worker 节点。
'

#------------------------------------------------------------------------------------------------------------
#-------------------------------------------检查初始化结果----------------------------------------------------
# 只在 master 节点执行
kubectl get nodes -o wide

#------------------------------------------------------------------------------------------------------------
#-------------------------------------------安装 Ingress Controller-------------------------------------------
# 安装 Ingress Controller
# 只在 master 节点执行

if [ $ret -ne 0 ]; then
   kubectl apply -f https://gitee.com/happylay/Kubernetes/raw/master/kubernetes%20v1.15.4/install-script/nginx-ingress.yaml
else
   kubectl apply -f https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/install-script/nginx-ingress.yaml
fi; 
#------------------------------------------------------------------------------------------------------------
#------------------------------------------------安装 Kuboard------------------------------------------------
# 安装 Kuboard

if [ $ret -ne 0 ]; then
   kubectl apply -f https://gitee.com/happylay/Kubernetes/raw/master/kubernetes%20v1.15.4/install-script/kuboard.yaml
else
   kubectl apply -f https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/install-script/kuboard.yaml
fi; 
# 查看 Kuboard 运行状态：
kubectl get pods -l k8s.eip.work/name=kuboard -n kube-system

# 获取Token
# 如果您参考 www.kuboard.cn 提供的文档安装 Kuberenetes，可在第一个 Master 节点上执行此命令
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep kuboard-user | awk '{print $1}') >> ./kuboard-token.txt

echo '
访问地址：http://任意一个Worker节点的IP地址:32567/
'
#------------------------------------------------------------------------------------------------------------
# k8s-master也当作Node使用
kubectl taint node k8s-master  node-role.kubernetes.io/master-

#------------------------------------------------------------------------------------------------------------






















