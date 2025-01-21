FROM rust:1.81.0 as builder
RUN cargo new sincronizacoes_big_ms
WORKDIR /sincronizacoes_big_ms
ADD Cargo.toml .
ADD Cargo.lock .
COPY ./src/big_to_active_model ./src/big_to_active_model
RUN cargo build -r
COPY ./src ./src
RUN echo "" >> src/main.rs \
    && cargo build -r \
    && rm -rf ./release/build \
    && rm -rf ./release/deps

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /sincronizacoes_big_ms
RUN apt update && apt install tzdata -y && rm -rf /var/lib/apt/lists/*
COPY --from=builder /sincronizacoes_big_ms/target/release/sincronizacoes_big_ms .
CMD ["./sincronizacoes_big_ms"]
