docker build -t vidalgpr/multi-client:latest -t vidalgpr/multi-client:$SHA ./client
docker build -t vidalgpr/multi-server:latest -t vidalgpr/multi-server:$SHA ./server
docker build -t vidalgpr/multi-worker:latest -t vidalgpr/multi-worker:$SHA ./worker

docker push vidalgpr/multi-client:latest
docker push vidalgpr/multi-server:latest
docker push vidalgpr/multi-worker:latest

docker push vidalgpr/multi-client:$SHA
docker push vidalgpr/multi-server:$SHA
docker push vidalgpr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vidalgpr/multi-server:$SHA
kubectl set image deployments/client-deployment client=vidalgpr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vidalgpr/multi-worker:$SHA
