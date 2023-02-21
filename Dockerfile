RUN frrouting/frr 
#package manager encapulate all the protocols services (BGPD OSPDF IS-IS) (before was quagga)
RUN sudo apt-get update
RUN apt-get -y install busybox
RUN sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons
RUN sed -i 's/ospdfd=no/ospdfd=yes/g' /etc/frr/daemons
RUN sed -i 's/isisd=no/isisd=yes/g' /etc/frr/daemons
CMD ["bash", "service frr restart"]
