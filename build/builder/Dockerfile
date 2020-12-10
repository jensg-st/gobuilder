FROM ubuntu:20.10

ENV FLUX_DIR=/flux-data
ENV GOCACHE=/gocache

RUN mkdir /gocache

RUN apt-get update && apt-get install jq -y && apt-get -y install golang \
  &&  apt-get -y install podman && apt-get -y install git \
  && apt-get -y install make && apt-get -y install gpg && apt-get install -y runc

ADD build.sh /

ADD storage.conf /etc/containers/

RUN chmod 755 /build.sh

CMD ["/build.sh"]
