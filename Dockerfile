FROM golang:alpine as builder

ADD . /build/
WORKDIR /build

RUN GOOS=linux GARCH=amd64 CGO_ENABLED=0 go build -mod=vendor -o api-server .

FROM scratch

WORKDIR /app
COPY --from=builder /build/api-server /app/api-server

CMD [ "/app/api-server" ]
