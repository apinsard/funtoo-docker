FROM busybox

MAINTAINER Antoine Pinsard

ADD build.sh /
ADD prepare.sh /
ADD upgrade.sh /

RUN /build.sh
RUN /prepare.sh
RUN /upgrade.sh


CMD ["bash"]
