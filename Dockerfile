#build stage
FROM golang:alpine AS builder
RUN apk add --no-cache git
WORKDIR /go/src/app
COPY . .
RUN go get -d -v ./...
RUN go build -o /go/bin/app -v ./...

#final stage
FROM scratch
COPY --from=builder /go/bin/app /app
LABEL Name=desafio1 Version=0.0.1
EXPOSE 3000
CMD ["/app"]
