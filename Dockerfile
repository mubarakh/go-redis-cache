FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod tidy

COPY . .

RUN go build -o /app/main cmd/main.go

FROM debian:bullseye-slim

WORKDIR /root/

COPY --from=builder /app/main /usr/local/bin/main

COPY .env /root/.env

EXPOSE 8080

CMD ["/usr/local/bin/main"]