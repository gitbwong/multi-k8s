docker build -t dockerbwong/multi-client:latest -t dockerbwong/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dockerbwong/multi-server:latest -t dockerbwong/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dockerbwong/multi-worker:latest -t dockerbwong/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dockerbwong/multi-client:latest
docker push dockerbwong/multi-server:latest
docker push dockerbwong/multi-worker:latest

docker push dockerbwong/multi-client:$SHA
docker push dockerbwong/multi-server:$SHA
docker push dockerbwong/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dockerbwong/multi-server:$SHA
kubectl set image deployments/client-deployment client=dockerbwong/mutli-client:$SHA
kubectl set image deployments/worker-deployment worker=dockerbwong/multi-worker:$SHA
