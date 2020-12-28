FROM ubuntu:16.04

MAINTAINER Stanislaw Baranski <stan@stan.bar>

ENV STELLAR_CORE_VERSION 15.1.0-41
ENV HORIZON_VERSION 1.13.0-93
ENV CONFD_VERSION 0.15.0

EXPOSE 5432
EXPOSE 8000
EXPOSE 6060
EXPOSE 11625
EXPOSE 11626

ADD dependencies /
RUN ["chmod", "+x", "dependencies"]
RUN /dependencies

ADD install /
RUN ["chmod", "+x", "install"]
RUN /install

RUN ["mkdir", "-p", "/opt/stellar"]
RUN ["touch", "/opt/stellar/.docker-ephemeral"]

RUN ["ln", "-s", "/opt/stellar", "/stellar"]
RUN ["ln", "-s", "/opt/stellar/core/etc/stellar-core.cfg", "/stellar-core.cfg"]
RUN ["ln", "-s", "/opt/stellar/horizon/etc/horizon.env", "/horizon.env"]
ADD common /opt/stellar-default/common
ADD pubnet /opt/stellar-default/pubnet
ADD testnet /opt/stellar-default/testnet
ADD standalone /opt/stellar-default/standalone
ADD confd /etc/confd


ADD start /
RUN ["chmod", "+x", "start"]

ENTRYPOINT ["/start"]
