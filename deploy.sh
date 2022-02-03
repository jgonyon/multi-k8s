docker build -t jgonyon/multi-client:latest -t jgonyon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jgonyon/multi-server:latest -t jgonyon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jgonyon/multi-worker:latest -t jgonyon.multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jgonyon/multi-client:latest
docker push jgonyon/multi-server:latest
docker push jgonyon/multi-worker:latest
docker push jgonyon/multi-client:$SHA
docker push jgonyon/multi-server:$SHA
docker push jgonyon/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jgonyon/multi-server:$SHA
kubectl set image deployments/client-deployment client=jgonyon/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jgonyon/multi-worker:$SHA
