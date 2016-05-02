openstack network create PCF_NETWORK
#infrastructure network
neutron subnet-create PCF_NETWORK --gateway 10.0.0.1 10.0.0.0/24
#deployment network
neutron subnet-create PCF_NETWORK --gateway 10.0.1.1 10.0.1.0/24


#set gateway and connect to the internal network
neutron router-create infrastructure
neutron router-gateway-set infrastructure net04_ext
neutron router-interface-add infrastructure 7982465c-2169-41d7-be92-9ceb193405dd
neutron router-interface-add infrastructure 9cc537a6-1a12-4152-9e57-99abf158247f

#Need to automate the net id
openstack server create \
              --image OpsManager-1.6.12 \
              --flavor m1.medium \
              --key-name shaozhen \
              --nic net-id=6f92e1b6-6e75-41fa-b599-802212a6c26b,v4-fixed-ip=10.0.0.4 \
              --security-group default \
              --availability-zone nova \
              --wait \
              jumpbox

openstack ip floating add 10.65.144.60 jumpbox              
