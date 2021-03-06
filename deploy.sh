docker build -t fgiraldolumu/multi-client-k8s:latest -t fgiraldolumu/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t fgiraldolumu/multi-server-k8s-pgfix:latest -t fgiraldolumu/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t fgiraldolumu/multi-worker-k8s:latest -t fgiraldolumu/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push fgiraldolumu/multi-client-k8s:latest
docker push fgiraldolumu/multi-server-k8s-pgfix:latest
docker push fgiraldolumu/multi-worker-k8s:latest

docker push fgiraldolumu/multi-client-k8s:$SHA
docker push fgiraldolumu/multi-server-k8s-pgfix:$SHA
docker push fgiraldolumu/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fgiraldolumu/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=fgiraldolumu/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=fgiraldolumu/multi-worker-k8s:$SHA
