# Notice:
# When updating this file, please also update virtualization/Docker/Dockerfile.dev
# This way, the development image and the production image are kept in sync.

FROM homeassistant/raspberrypi3-homeassistant:0.73.2
LABEL maintainer="Justin Dray <justin@dray.be>"

RUN apk update
RUN apk add git mosquitto
RUN pip3 install awscli

ADD entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh" ]
