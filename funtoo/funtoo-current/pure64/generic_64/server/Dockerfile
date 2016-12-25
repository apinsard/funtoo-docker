FROM funtoo-current-pure64-generic_64

MAINTAINER Antoine Pinsard

ADD prepare.sh /
ADD upgrade.sh /

RUN /prepare.sh server
RUN /upgrade.sh

CMD ["bash", "-l"]
