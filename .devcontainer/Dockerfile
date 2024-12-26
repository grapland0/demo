FROM ubuntu:22.04
WORKDIR /root
COPY prepare.sh .
RUN chmod u+x prepare.sh && /bin/bash ./prepare.sh && rm -fr ./prepare.sh
CMD /bin/bash