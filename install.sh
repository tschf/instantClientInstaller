#!/bin/bash
printf "Automated installer of oracle client for Ubuntu" 
# Install dependencies
sudo apt update
sudo apt install -y alien

# Download files. Example specific to 19.3 
# Some links were not correct on the downloads page
# (still pointing to a license page), but easy enough to
# figure out from working ones 
wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-basiclite-19.3.0.0.0-1.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm 

# Install all 3 RPM's downloaded 
sudo alien -i oracle-instantclient19.3-*.rpm

# Install SQL*Plus dependency&nbsp; 
sudo apt install -y libaio1

# Create Oracle environment script
printf "\n\n# Oracle Client environment\n \
export LD_LIBRARY_PATH=/usr/lib/oracle/19.3/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export ORACLE_HOME=/usr/lib/oracle/19.3/client64\n" | sudo tee /etc/profile.d/oracle-env.sh > /dev/null

printf "Install complete. You may need to set up your environment before a reboot with the command\n
. /etc/profile.d/oracle-env.sh\n"
