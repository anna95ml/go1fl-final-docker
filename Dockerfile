FROM golang:1.22

WORKDIR /app

COPY go.mod go.sum ./

# без этого не собирается образ
ENV GOPROXY=direct
ENV GOINSECURE=*
# и без этого не собирается образ
RUN git config --global http.sslVerify false 

RUN go mod download

COPY *.go ./

COPY *.db ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /my_app

CMD ["/my_app"]