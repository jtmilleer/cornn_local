FROM ubuntu:18.04

WORKDIR /app

COPY scripts/ ./scripts/

RUN chmod +x ./scripts/setup.sh

CMD["./scripts/setup.sh"]
