# !/bin/bash

#CRÉATION DE LA VLAN ID 11 AVEC 1 MACHINES
ip link add br0 type bridge
ip link set dev br0 up
ip link add vxlan10 type vxlan id 10 dstport 4789
ip link set dev vxlan10 up

brctl addif br0 vxlan10
brctl addif br0 eth1

#CRÉATION DE LA VLAN ID 11 AVEC DEUX MACHINES
ip link add br1 type bridge
ip link set dev br1 up
ip link add vxlan11 type vxlan id 11 dstport 4789
ip link set dev vxlan11 up

brctl addif br1 vxlan11
brctl addif br1 eth2

brctl addif br1 eth3

vtysh << STOP
conf t
hostname router_hrazanam-2
no ipv6 forwarding
!
interface  eth0
ip address 10.1.1.2/30
ip ospf area 0
!
interface lo
ip address 1.1.1.2/32
ip ospf area 0
!
router bgp 1
neighbor 1.1.1.1 remote-as 1
neighbor 1.1.1.1 update-source lo
!
address-family l2vpn evpn
neighbor 1.1.1.1 activate
advertise-all-vni
exit-address-family
!
router ospf
!
STOP
