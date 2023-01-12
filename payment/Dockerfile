FROM golang:1.7

RUN git config --global http.sslVerify false
COPY . /go/src/github.com/microservices-demo/payment
WORKDIR /go/src/github.com/microservices-demo/payment

RUN go get -u github.com/FiloSottile/gvt
RUN gvt restore && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app github.com/microservices-demo/payment/cmd/paymentsvc

FROM alpine:3.4

ENV	SERVICE_USER=myuser \
	SERVICE_UID=10001 \
	SERVICE_GROUP=mygroup \
	SERVICE_GID=10001

RUN	addgroup -g ${SERVICE_GID} ${SERVICE_GROUP} && \
	adduser -g "${SERVICE_NAME} user" -D -H -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER} && \
	apk add --update libcap

WORKDIR /
COPY --from=0 /app /app

RUN	chmod +x /app && \
	chown -R ${SERVICE_USER}:${SERVICE_GROUP} /app && \
	setcap 'cap_net_bind_service=+ep' /app; exit 0

USER ${SERVICE_USER}

CMD ["/app", "-port=80"]
EXPOSE 80