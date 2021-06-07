docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker

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