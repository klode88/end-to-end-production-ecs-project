# stage 1: build the gatus app 

FROM golang:alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o gatus .

# stage 2 : run the app

FROM alpine:latest
RUN adduser -D appuser
COPY --from=builder /app/gatus /app/gatus
COPY config.yaml /app/config.yaml
ENV GATUS_CONFIG_PATH=/app/config.yaml
ENV PORT=8080
EXPOSE 8080
USER appuser
ENTRYPOINT ["/app/gatus" ]









