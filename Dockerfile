FROM public.ecr.aws/docker/library/golang:1.24.4-bookworm AS builder
WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY . ./

RUN go build -o main

FROM public.ecr.aws/amazonlinux/amazonlinux:2023-minimal AS runner
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
ENTRYPOINT ["./main"]
