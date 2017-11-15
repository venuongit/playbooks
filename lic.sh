#!/bin/bash
for i in `cat /home/vkedhari/ERP/ERPSios` ; do ssh -q $i  'hostname>>/home/vkedhari/ansible/ERP/liclist.txt ;sudo /opt/LifeKeeper/bin/lklicmgr >> /home/vkedhari/ansible/ERP/liclist.txt ' ; done
