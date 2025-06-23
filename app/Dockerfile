FROM ubuntu:22.04

# 필수 도구 설치
RUN apt-get update && \
    apt-get install -y curl git ca-certificates lsb-release gnupg && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash

