
K8S_VERSION=1.25
CLUSTER_NAME=xxx

eksctl create cluster --name=bpk-ckf \
  --region=eu-west-1 \
  --version=$K8S_VERSION \
  --with-oidc \
  --instance-types=t3.xlarge \
  --ssh-access

eksctl create iamserviceaccount  \
 --name ebs-csi-controller-sa  \
 --namespace kube-system  \
 --cluster bpk-ckf  \
 --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy  \
 --approve  \
 --role-only \
 --role-name AmazonEKS_EBS_CSI_DriverRole

eksctl create addon --name aws-ebs-csi-driver \
 --cluster bpk-ckf \
 --service-account-role-arn arn:aws:iam::xxxxxxxxxx:role/AmazonEKS_EBS_CSI_DriverRole \
 --force