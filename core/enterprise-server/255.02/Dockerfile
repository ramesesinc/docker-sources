FROM ramesesinc/alpine-java:jdk7

COPY /apps /apps

WORKDIR /apps/server/bin
RUN tar -xf sh.tar.gz
RUN rm -f sh.tar.gz

WORKDIR /apps
RUN tar -xf sh.tar.gz
RUN rm -f sh.tar.gz

RUN ln -s /apps/server/services /services
RUN ln -s /apps/server/services/apps/enterprise /apps/enterprise

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

CMD ["/bin/bash", "/apps/start.sh"]

EXPOSE 8070