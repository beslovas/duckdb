FROM debian:bookworm-slim

ARG TARGETARCH
ARG DUCKDB_VERSION=v1.3.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L -o duckdb_cli.zip "https://github.com/duckdb/duckdb/releases/download/${DUCKDB_VERSION}/duckdb_cli-linux-${TARGETARCH}.zip" \
    && unzip duckdb_cli.zip \
    && rm duckdb_cli.zip

EXPOSE 4213

ENTRYPOINT [ "/duckdb", "-ui" ]