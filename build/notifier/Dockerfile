FROM ubuntu:20.10

RUN apt-get update && apt-get install jq -y && apt-get -y install gpg \
  &&  apt-get -y install curl

ENV FLUX_DIR=/flux-data

ADD build.sh /

ADD twilio.gpg /

RUN chmod 755 /build.sh

CMD ["/build.sh"]
