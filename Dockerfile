FROM golang:1.22

WORKDIR /app

COPY go.mod go.sum ./
# без этого не собирается образ
RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates
# и без этого не собирается образ
ENV GOPROXY=https://proxy.golang.org,direct

RUN go mod download

COPY *.go ./

COPY *.db ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /my_app

CMD ["/my_app"]