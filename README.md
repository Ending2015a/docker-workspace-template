# docker-workspace-template
My personal workspace template for docker


## How To Use
1. Customize your Python dependencies in `scripts/setup.sh`
2. Build the workspace image with the following command
```bash
# Build the base docker "my-ws-base"
./scripts/docker-build --base --docker-name my-ws-base
# Build the workspace "my-ws"
./scripts/docker-build --docker-name my-ws --base-image my-ws-base
# Start the workspace "my"
./scripts/docker-start --bash --docker-name my-ws
```
