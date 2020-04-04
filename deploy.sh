docker build -t dustinvogel/multi-client:lastest -t dustinvogel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dustinvogel/multi-server:lastest -t dustinvogel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dustinvogel/multi-worker:lastest -t dustinvogel/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dustinvogel/multi-client:lastest
docker push dustinvogel/multi-server:lastest
docker push dustinvogel/multi-worker:lastest
docker push dustinvogel/multi-client:$SHA
docker push dustinvogel/multi-server:$SHA
docker push dustinvogel/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dustinvogel/multi-server:$SHA
kubectl set image deployments/client-deployment client=dustinvogel/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dustinvogel/multi-worker:$SHA




