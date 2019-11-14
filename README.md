# Kubernetes
k8s快速安装脚本

# 配置要求
2核4G服务器
centos7.6系统

# 版本说明

# Kubernetes v1.16.2 安装后的软件版本
calico 3.9
nginx-ingress 1.5.5
Docker 18.09.7

# Kubernetes v1.16.2安装步骤
# master

curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.16.2/k8s.sh | sh

# node

curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.16.2/k8s-node.sh | sh

# Kubernetes v1.15.4 安装后的软件版本
calico 3.8.2
nginx-ingress 1.5.3
Docker 18.09.7

# Kubernetes v1.15.4 安装步骤
# master

curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/k8s.sh | sh

# node

curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/k8s-node.sh | sh

# 安装helm-只适用于v1.15.x版本

1.第一步-创建文件夹方便删除
mkdir -p /usr/local/helm && cd /usr/local/helm

2.第二步-上传helm安装包
wget https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/helm-script/helm-v2.15.2-linux-amd64.tar.gz

2.第三步-安装helm
curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/helm-script/helm.sh | sh

由于网络问题,第三步需要多次执行才能安装成功,当k8s成功安装redis测试应用,说明helm安装成功，否则重复执行第三步脚本。

2019.11.14 更新记录
# Kubernetes v1.16.2安装步骤-变更
# master
参数：设置master主节点名称  设置master-ip地址  设置master-dns名称  设置pod容器所在网段
curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.16.2/k8s.sh | sh -s k8s-master 172.17.16.9 apiserver.k8s 10.100.0.1/16

# node
参数：设置node节点名称  设置master-ip地址  设置master-dns名称  设置pod容器所在网段
curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.16.2/k8s-node.sh | sh -s k8s-node-1 172.17.16.9 apiserver.k8s 10.100.0.1/16

# Kubernetes v1.15.4 安装步骤-变更
# master
参数：设置master主节点名称  设置master-ip地址  设置master-dns名称  设置pod容器所在网段
curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/k8s.sh | sh -s k8s-master 172.17.16.9 apiserver.k8s 10.100.0.1/20

# node
参数：设置node节点名称  设置master-ip地址  设置master-dns名称  设置pod容器所在网段
curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/k8s-node.sh | sh -s k8s-node-1 172.17.16.9 apiserver.k8s 10.100.0.1/20


















