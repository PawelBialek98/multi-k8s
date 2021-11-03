docker build -t pawelbialek/multi-client:latest -t pawelbialek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pawelbialek/multi-server:latest -t pawelbialek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pawelbialek/multi-worker:latest -t pawelbialek/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pawelbialek/multi-client:latest
docker push pawelbialek/multi-server:latest
docker push pawelbialek/multi-worker:latest

docker push pawelbialek/multi-client:$SHA
docker push pawelbialek/multi-server:$SHA
docker push pawelbialek/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=pawelbialek/multi-client:$SHA
kubectl set image deployments/server-deployment server=pawelbialek/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pawelbialek/multi-worker:$SHA