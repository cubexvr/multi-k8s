docker build -t cubexvr/multi-client:latest -t cubexvr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cubexvr/multi-server:latest -t cubexvr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cubexvr/multi-worker:latest -t cubexvr/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push cubexvr/multi-client:latest 
docker push cubexvr/multi-client:$SHA
docker push cubexvr/multi-server:latest
docker push cubexvr/multi-server:$SHA
docker push cubexvr/multi-worker:latest
docker push cubexvr/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=cubexvr/multi-client:$SHA
kubectl set image deployments/server-deployment server=cubexvr/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=cubexvr/multi-worker:$SHA

