FROM frrouting/frr 
RUN echo "package manager encapulate all the protocols services (BGPD OSPDF IS-IS) (before was quagga)"
RUN apk update
RUN apk upgrade
# RUN apk -y add busybox
RUN sed -i 's/zebra=no/zebra=yes/g' /etc/frr/daemons
RUN sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons
RUN sed -i 's/ospfd=no/ospfd=yes/g' /etc/frr/daemons
RUN sed -i 's/isisd=no/isisd=yes/g' /etc/frr/daemons
RUN chown -R frr:frr /etc/frr