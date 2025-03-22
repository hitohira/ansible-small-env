#!/bin/bash

get_hosts(){
 echo $(awk "/\[$1\]/{flag=1; next} flag && NF {print} !NF{flag=0}" /home/ansible/work/inventory/hosts)
}

# check exec user
if [[ $(whoami) != "ansible" ]]; then
  echo "ERROR: user is not ansible.[$(whoami)]"
  exit 1
fi

# generate ssh key
if [[ ! -f /home/ansible/.ssh/id_rsa ]]; then
  ssh-keygen -t rsa -b 2048 -f /home/ansible/.ssh/id_rsa -N ""
else
	echo "INFO: id_rsa already exists. skip ssh-keygen"
fi
chmod 600 /home/ansible/.ssh/id_rsa
chmod 644 /home/ansible/.ssh/id_rsa.pub

# get ansible taget node from hosts file
HOST_LIST_NODE=$(get_hosts "node")
HOST_LIST_NGINX=$(get_hosts "proxy")
HOST_LIST="$HOST_LIST_NODE $HOST_LIST_NGINX"
echo "INFO: target nodes are"
echo "$HOST_LIST"

# clean up known_hosts file
KNOWN_HOSTS_FILE=/home/ansible/.ssh/known_hosts
> $KNOWN_HOSTS_FILE

# setting known_hosts and get fingerprint of target nodes
for HOST in $HOST_LIST; do
	echo "INFO: ssh to $HOST"
  ssh-keyscan -H "$HOST" >> "$KNOWN_HOSTS_FILE"
  sshpass -p "p@ssword01" ssh-copy-id -i /home/ansible/.ssh/id_rsa.pub "ansible@$HOST"
done

echo "INFO: ssh setting finished"
exit 0

