# hackathon-chart

This is a simplified helm chart to create a deployment, service and ingress to run a small app in kubernetes for the
hackathon.

## Usage

First build a docker image. For example in this repo there is a small hello world rest api. It can be built with

```bash
GOOS=linux GOARCH=amd64 go build main.go
docker buildx build --platform linux/amd64 -t registry.hf.runs.onstackit.cloud/group0/hello-world:v0.0.2 -f Dockerfile .
```

After that you can use the chart to deploy the newly created app.

```bash
helm upgrade --install test https://github.com/patrickkoss/hackathon-chart/releases/download/v0.1.0/hackathon-apps-0.1.0.tgz -n group0 \                                               
  --set image.repository=registry.hf.runs.onstackit.cloud/group0/hello-world --set service.port=8080 \
  --set image.tag=v0.0.2 \
  --set ingress.enabled=true \
  --set ingress.domain=test.group0.hf.runs.onstackit.cloud
```

This will create a deployment, service and ingress for the app. The app will be available
at `test.group0.hf.runs.onstackit.cloud`.
Since our rest api is listing on port 8080, the ingress will route the traffic to the service on port 8080 because we
set `service.port` to 8080.
