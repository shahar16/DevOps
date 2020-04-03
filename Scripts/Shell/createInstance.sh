#!/bin/bash

flagGivven=0
zone="europe-west6-a"

usage() { echo "This script create a new VM instance.
You should run this script with -n flag to specify the name of the instance."; }

while [ "$1" != "" ]; do
    case $1 in
        -n | --name )           shift; slaveName=$1; flagGivven=1;;
        -h | --help )           usage
                                exit
    esac
    shift
done

if [ $flagGivven -eq 0 ]
then
    usage
    exit
fi

if [ -z $slaveName ]
then
    echo "You must give you new instance a name."
    exit
fi

echo "============ instance name: ${slaveName} ============"

echo "[STEP 1] Create new instance."
# gcloud compute instances create ${slaveName} --image-family ubuntu-1604-lts  --image-project ubuntu-os-cloud --machine-type=n1-standard-4 --create-disk size=32,type=pd-standard --tags=http-server,https-server --zone=${zone}
echo "Going to sleep for 1 minute before step 2."
sleep 60

echo "[STEP 2] Enable SSH connection to the machines."
# gcloud compute ssh --zone=${zone} ${slaveName} --command 'sudo sed -i -e "s|PasswordAuthentication no|PasswordAuthentication yes|g" /etc/ssh/sshd_config'

echo "[STEP 3] Creating shahar user on instance."
# gcloud compute ssh --zone=${zone} ${slaveName} --command 'sudo useradd -m  -s /bin/bash -G adm,dialout,cdrom,floppy,audio,dip,video,plugdev,netdev,lxd,ubuntu,google-sudoers shahar'
# gcloud compute ssh --zone=${zone} ${slaveName} --command 'echo -e "Welcome1\nWelcome1" | sudo passwd shahar'
# gcloud compute ssh --zone=${zone} ${slaveName} --command 'sudo systemctl reload sshd'

echo "[STEP 4] Prepare machine."
gcloud compute ssh --zone=${zone} ${slaveName} --command 'git clone https://github.com/shahar16/DevOps.git'
gcloud compute ssh --zone=${zone} ${slaveName} --command './DevOps/Scripts/Shell/prepareMachine.sh'

echo "[STEP 4] Create node in Jenkins."

# if [ $nodesToCreate -gt 0 ]
# then
#     echo "nodesToCreate is $nodesToCreate "
#     ind=0
#     while [ ${ind} -lt ${nodesToCreate} ]
#     do
#         echo "manipulate the file"
#         echo "java -jar jenkins-cli.jar -noCertificateCheck -s https://flprtgcpdev.jaas-gcp.cloud.sap.corp/ -auth P2001777765:1197b6154de1871cbd58852e6d5c0ca1df slaveNode.xml"
#         ind=$[${ind}+1]
#     done
#     wait
# fi

