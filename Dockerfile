FROM       alpine:latest
MAINTAINER Tim Brandin <tim.brandin@gmail.com>
EXPOSE     9104

ENV  GOPATH /go
ENV APPPATH $GOPATH/src/github.com/timbrandin/mongodb_exporter
COPY . $APPPATH
RUN apk add --update -t build-deps go git mercurial libc-dev gcc libgcc \
    && cd $APPPATH && go get -d && go build -o /bin/mongodb_exporter \
    && apk del --purge build-deps && rm -rf $GOPATH

ENTRYPOINT [ "/bin/mongodb_exporter" ]
