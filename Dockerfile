FROM golang:1.17 AS build

WORKDIR /usr/src/app

COPY go.mod ./

COPY main.go ./

RUN go build -o /server

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /server /server

USER nonroot:nonroot

ENTRYPOINT ["/server"]