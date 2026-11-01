# Используем актуальный официальный образ Rust
FROM rust:1.99-slim as builder
WORKDIR /app
COPY . .
# Собираем бинарный файл tunnix
RUN cargo build --release

# Финальный образ
FROM debian:bookworm-slim
# Копируем скомпилированный бинарник из предыдущего этапа
COPY --from=builder /app/target/release/tunnix /usr/local/bin/tunnix
# Запускаем сервер, используя переменную окружения $PORT, которую предоставляет Render
CMD tunnix server --listen "0.0.0.0:$PORT" --password "$TUNNIX_PASSWORD"
