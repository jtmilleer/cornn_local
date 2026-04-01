FROM ubuntu:18.04

WORKDIR /app

COPY scripts/ ./scripts/

RUN chmod +x ./scripts/entrypoint.sh


ENTRYPOINT ["./scripts/entrypoint.sh"]
