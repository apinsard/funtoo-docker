FROM busybox

MAINTAINER Antoine Pinsard

ADD build.sh /

RUN /build.sh

RUN sed -e 's/#rc_sys=""/rc_sys="docker"/g' -i /etc/rc.conf

CMD ["bash"]
