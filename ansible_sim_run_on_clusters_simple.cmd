@echo off
echo Reading Data from Legden01
plink 10.141.64.48  -l in10c2 sh /home/users/in10c2/moni/readALLphyIP_TPF.sh
echo Reading Data from Legdgn01
plink 10.141.64.113 -l in10c2 df -gt /usr/sap/scratch
echo Reading Data from Legdgi01
plink 10.141.112.30 -l in10c2 df -gt /usr/sap/scratch
echo Reading Data from Legpgi01
plink 10.141.112.62 -l in10c2 df -gt /usr/sap/scratch
echo Reading Data from Legpgn01
plink 10.141.64.104 -l in10c2 df -gt /usr/sap/scratch
