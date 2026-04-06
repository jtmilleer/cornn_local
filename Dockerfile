FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
git \
curl \
wget \
build-essential \
python3.8 \
python3.8-dev \
python3.8-venv \
python3-pip \
libgl1-mesa-glx \
libglib2.0-0 \
ca-certificates \
xvfb

# make python3.8 default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

WORKDIR /app

COPY scripts/ ./scripts/

RUN chmod +x ./scripts/entrypoint.sh ./scripts/setup.sh

# Run setup during build as root with 8 threads
RUN ./scripts/setup.sh 8

ENTRYPOINT ["./scripts/entrypoint.sh"]
