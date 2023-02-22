FROM frrouting/frr
RUN rm /etc/frr/daemons
COPY ./daemons /etc/frr/daemons
RUN echo "package manager encapulate all the protocols services (BGPD OSPDF IS-IS) (before was quagga)"
RUN apk update
#RUN apk add busybox
#RUN chown -R frr:frr /etc/frr
RUN sed -i 's/zebra=no/zebra=yes/g' /etc/frr/daemons
RUN sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons
RUN sed -i 's/ospfd=no/ospfd=yes/g' /etc/frr/daemons
RUN sed -i 's/isisd=no/isisd=yes/g' /etc/frr/daemons
