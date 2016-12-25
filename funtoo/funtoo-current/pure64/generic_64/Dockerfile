FROM busybox

MAINTAINER Antoine Pinsard

ADD build.sh /
RUN /build.sh current pure64 generic_64-pure64

CMD ["bash", "-l"]
