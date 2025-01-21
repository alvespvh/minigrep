run:
	cargo run

release:
	cargo run --release

build:
	cargo build -r

clean:
	du -hs ./target/*
	cargo clean

docker:
	docker compose down
	docker compose build
	docker compose up

format:
	cargo fmt
	cargo clippy

commit:
	cargo fmt
	cargo clippy
	git add .
	git commit
