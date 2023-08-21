Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
package_update: true
package_upgrade: true
runcmd:
- yum update -y
- yum install docker -y
- systemctl start docker
- systemctl enable docker
- usermod -aG docker ec2-user
- chkconfig docker on
- curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
- chmod +x /usr/local/bin/docker-compose
- mv /usr/local/bin/docker-compose /bin/docker-compose
- yum install -y amazon-efs-utils
- yum install -y nfs-utils
- file_system_id_1=fs-0fdf921c93a54abce
- efs_mount_point_1=/mnt/efs
- mkdir -p "${efs_mount_point_1}"
- test -f "/sbin/mount.efs" && printf "\n${file_system_id_1}:/ ${efs_mount_point_1} efs tls,_netdev\n" >> /etc/fstab || printf "\n${file_system_id_1}.efs.us-east-1.amazonaws.com:/ ${efs_mount_point_1} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0\n" >> /etc/fstab
- test -f "/sbin/mount.efs" && grep -ozP 'client-info]\nsource' '/etc/amazon/efs/efs-utils.conf'; if [[ $? == 1 ]]; then printf "\n[client-info]\nsource=liw\n" >> /etc/amazon/efs/efs-utils.conf; fi;
- retryCnt=15; waitTime=30; while true; do mount -a -t efs,nfs4 defaults; if [ $? = 0 ] || [ $retryCnt -lt 1 ]; then echo File system mounted successfully; break; fi; echo File system not available, retrying to mount.; ((retryCnt--)); sleep $waitTime; done;

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash
sudo echo "
    services:
      wordpress:
        image: wordpress:latest
        volumes:
          - /mnt/efs/wordpress:/var/www/html
        ports:
          - "80:80"
        environment:
          WORDPRESS_DB_HOST: database-2.cnqrkzyc9bxk.us-east-1.rds.amazonaws.com
          WORDPRESS_DB_USER: admin
          WORDPRESS_DB_PASSWORD: 12345678
          WORDPRESS_DB_NAME: dbdocker
" > /mnt/efs/docker-compose.yml
sudo docker-compose -f /mnt/efs/docker-compose.yml up -d
--//--
