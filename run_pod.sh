kubectl run aws-lambda-python38-container --image=aws-lambda-python38 --image-pull-policy=Never --restart=Never
kubectl port-forward pod/aws-lambda-python38-container 8080
