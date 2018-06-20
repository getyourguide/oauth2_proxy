FROM golang:1.10.2 as builder
WORKDIR /go/src/github.com/getyourguide/oauth2_proxy/
COPY . /go/src/github.com/getyourguide/oauth2_proxy/
RUN go get .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /
COPY --from=builder /go/src/github.com/getyourguide/oauth2_proxy/ .
CMD ["./oauth2_proxy"]
