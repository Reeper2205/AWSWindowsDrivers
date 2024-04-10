## Powershell Script Install AWS Drivers ##

# NVME driver download
Invoke-WebRequest https://s3.amazonaws.com/ec2-windows-drivers-downloads/NVMe/Latest/AWSNVMe.zip -outfile $env:USERPROFILE\nvme_driver.zip
Expand-Archive $env:userprofile\nvme_driver.zip -DestinationPath $env:userprofile\nvme_driver

# install NVME driver
cd $env:userprofile\nvme_driver
.\install.ps1 -NoReboot

#ENA driver download
invoke-webrequest https://ec2-windows-drivers-downloads.s3.amazonaws.com/ENA/Latest/AwsEnaNetworkDriver.zip -outfile $env:USERPROFILE\AwsEnaNetworkDriver.zip
expand-archive $env:userprofile\AwsEnaNetworkDriver.zip -DestinationPath $env:userprofile\AwsEnaNetworkDriver

#Install ena driver
cd $env:userprofile\AwsEnaNetworkDriver\
.\install.ps1

#Check PV driver version
Get-ItemProperty HKLM:\SOFTWARE\Amazon\PVDriver

# Download PV driver
Invoke-WebRequest https://s3.amazonaws.com/ec2-windows-drivers-downloads/AWSPV/Latest/AWSPVDriver.zip -outfile $env:USERPROFILE\pv_driver.zip
Expand-Archive $env:userprofile\pv_driver.zip -DestinationPath $env:userprofile\pv_drivers

#install PV driver
cd $env:userprofile\pv_drivers
.\install.ps1 -Quiet -NoReboot

#Restart Instance after driver isntalls
Restart-Computer
