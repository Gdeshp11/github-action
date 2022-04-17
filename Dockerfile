FROM golang:1.15-alpine AS build
ENV PROJECT_DIR=go_example
WORKDIR /src
COPY $PROJECT_DIR/go.mod .
RUN go mod download
COPY $PROJECT_DIR/main.go .
ADD $PROJECT_DIR/microservice ./microservice
RUN CGO_ENABLED=0 go build -o /bin/helloserver

FROM scratch
COPY --from=build /bin/helloserver /bin/helloserver
ENTRYPOINT ["/bin/helloserver"]
