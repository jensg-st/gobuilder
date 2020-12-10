FROM ubuntu:20.10

RUN apt-get update && apt-get install jq -y && apt-get -y install golang \
  &&  apt-get -y install podman && apt-get -y install git \
  && apt-get -y install make && apt-get -y install gpg && apt-get install -y runc \
  && apt-get -y install wget

RUN wget https://github.com/vorteil/vorteil/releases/download/0.5.7/vorteil_linux-x86.tar.gz && tar -xvzf vorteil_linux-x86.tar.gz && mv /vorteil /vorteilcli && ls -la /

RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-307.0.0-linux-x86_64.tar.gz \
  && tar -xvzf google-cloud-sdk-307.0.0-linux-x86_64.tar.gz && cd google-cloud-sdk && ./install.sh --quiet

ADD storage.conf /etc/containers/

ENV FLUX_DIR=/flux-data

ADD build.sh /

ADD gcloud.json.gpg /

ADD provisionGCP.gpg /

RUN chmod 755 /build.sh

CMD ["/build.sh"]
