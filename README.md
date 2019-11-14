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

1.第一步
wget https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/helm-script/helm-v2.15.2-linux-amd64.tar.gz

2.第二步
curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/master/kubernetes%20v1.15.4/helm-script/helm.sh | sh

网络问题,第二步需要多次执行才能安装成功
