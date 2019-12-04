# 安装helm-只适用于v1.15.x版本
````
1.第一步-创建文件夹方便删除
mkdir -p /usr/local/helm && cd /usr/local/helm

2.第二步-上传helm安装包
wget https://raw.githubusercontent.com/happylay-cloud/Kubernetes/helm/helm/2.15.2/helm-script/helm-v2.15.2-linux-amd64.tar.gz

2.第三步-安装helm
curl -ssL https://raw.githubusercontent.com/happylay-cloud/Kubernetes/helm/helm/2.15.2/helm-script/helm.sh | sh
由于网络问题,第三步需要多次执行才能安装成功,当k8s成功安装redis测试应用,说明helm安装成功，否则重复执行第三步脚本。
````















