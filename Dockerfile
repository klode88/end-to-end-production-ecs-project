# stage 1: build the gatus app 

FROM golang:alpine AS builder
WORKDIR /app
COPY app/go.mod app/go.sum ./
RUN go mod download
COPY app/. .
RUN CGO_ENABLED=0 GOOS=linux go build -o gatus .

# stage 2 : run the app

FROM alpine:latest
RUN adduser -D appuser
COPY --from=builder /app/gatus /app/gatus
COPY app/config.yaml /app/config.yaml
ENV GATUS_CONFIG_PATH=/app/config.yaml
ENV PORT=8080
EXPOSE 8080
USER appuser
ENTRYPOINT ["/app/gatus" ]









