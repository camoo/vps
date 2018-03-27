#!/bin/bash
# Secure VPS server
# -------------------------------------------------------------------------
# Copyright (c) 2018 CAMOO
# Maintainer: Camoo vsp (vps@camoo.hosting)
# -------------------------------------------------------------------------

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
   -p|--port)
    PORT="$2"
    shift # past argument
    ;;
   -u|--sudo)
    SUDOUSER="$2"
    shift # past argument
    ;;
   -pw|--passwd)
    PASSWD="$2"
    shift # past argument
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

if [ -z "$PORT" ]; then
  echo "Server ssh port is missing: usage -p "
  echo "[FAILED]"
 exit 0
fi

if [ -z "$SUDOUSER" ]; then
  echo "Sudo user is missing: usage -u "
  echo "[FAILED]"
 exit 0
fi

apt-get update
apt-get dist-upgrade
apt-get update

# change default port
sed -i "s/^Port.*/Port ${PORT}/" /etc/ssh/sshd_config
sed -i "s/^PermitRootLogin.*/PermitRootLogin no/" /etc/ssh/sshd_config
echo "AllowUsers ${SUDOUSER}" >> /etc/ssh/sshd_config
systemctl restart sshd

# create sudo user
useradd --home /home/${SUDOUSER} -m --shell /bin/bash ${SUDOUSER}
# set password if not empty
if [ -z "$PASSWD" ]; then
  echo $(echo -e "$PASSWD\n$PASSWD" | passwd $SUDOUSER)
fi
gpasswd -a ${SUDOUSER} sudo
chmod 711 /home/${SUDOUSER}

echo "[DONE]"

if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 $1
fi
