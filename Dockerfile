FROM rust:1.81.0 as builder
RUN cargo new minigrep
WORKDIR /minigrep
ADD Cargo.toml .
ADD Cargo.lock .
# COPY ./src/big_to_active_model ./src/big_to_active_model
RUN cargo build -r
COPY ./src ./src
RUN echo "" >> src/main.rs \
    && cargo build -r \
    && rm -rf ./release/build \
    && rm -rf ./release/deps

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /minigrep
RUN apt update && apt install tzdata -y && rm -rf /var/lib/apt/lists/*
COPY --from=builder /minigrep/target/release/minigrep .
CMD ["./minigrep"]
