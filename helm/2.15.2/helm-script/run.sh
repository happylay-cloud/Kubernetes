#!/bin/bash
##########################################################################
#Author : happylay 安徽理工大学
#Created Time : 2019-12-04 13:47
#Environment：CentOs7
##########################################################################
# 安装
if [ ! -f "./helm.zip" ];then
   curl -o helm.zip https://gitee.com/happylay/Kubernetes/repository/archive/helm.zip
   unzip ./helm.zip
else
   rm -f /usr/local/bin/helm > /dev/null 2>&1 
   unzip ./helm.zip
fi

while [ ! `kubectl get pods --namespace=happylay` > /dev/null 2>&1 ]
do
    #------------------------------------------------------------------------------------------------------------------
    helm del --purge redis > /dev/null 2>&1
  	#------------------------------------------------------------------------------------------------------------------
	# 解压
	tar -zxvf ./Kubernetes/helm/2.15.2/helm-script/helm-v2.15.2-linux-amd64.tar.gz
	mv ./linux-amd64/helm /usr/local/bin/ 
	chmod +x /usr/local/bin/helm
	#------------------------------------------------------------------------------------------------------------------
	helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.15.2 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
	#------------------------------------------------------------------------------------------------------------------
	kubectl create serviceaccount --namespace kube-system tiller
	kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
	#------------------------------------------------------------------------------------------------------------------
	kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
	#------------------------------------------------------------------------------------------------------------------
	helm version
	
	# 添加一个国内可以访问的阿里源，不过好像最近不更新了
	helm repo add ali https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts  
	# 更新源
	helm repo update
	# 下载chart
	helm fetch ali/redis
	# 部署应用
	helm install --name redis --set "persistence.enabled=false,mariadb.persistence.enabled=false" ali/redis --namespace happylay
	
	rm -rf ./Kubernetes
	rm -rf ./linux-amd64
	#------------------------------------------------------------------------------------------------------------------
done  
helm del --purge redis
rm -f ./helm.zip
echo 'success'