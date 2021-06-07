docker build -t parul5sahoo/multi-client:latest -t parul5sahoo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t parul5sahoo/multi-server:latest -t parul5sahoo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t parul5sahoo/multi-worker:latest -t parul5sahoo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push parul5sahoo/multi-client:latest
docker push parul5sahoo/multi-server:latest
docker push parul5sahoo/multi-worker:latest

docker push parul5sahoo/multi-client:$SHA
docker push parul5sahoo/multi-server:$SHA
docker push parul5sahoo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=parul5sahoo/multi-client:$SHA
kubectl set image deployments/server-deployment server=parul5sahoo/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=parul5sahoo/multi-worker:$SHA