#stage 1 : Build the Go application
FROM golang:1.22.5 AS base

WORKDIR /app

COPY go.mod  ./

RUN go mod download

COPY . .

RUN go build -o main .

#stage 2  Use a minimal image to run the Go application

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]