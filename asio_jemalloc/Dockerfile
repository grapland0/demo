FROM ubuntu:22.04
WORKDIR /root
COPY prepare.sh .
COPY test.cpp .
RUN chmod u+x prepare.sh && /bin/bash ./prepare.sh && rm -fr ./prepare.sh
CMD /bin/bash