# synology-tools
scripts and tools for synology nas

## scripts

collection of scripts

1. scan a simple cron scheduled script that applies OCR to scanned PDFs using the famous docker based ocrmypdf

To use the ocrmypdf you need to install docker first, for aarch64 based synology device see
https://stackoverflow.com/questions/52520008/can-i-install-docker-on-arm8-based-synology-nas

## notes on updating DSM

after updating DSM on my synology NAS, docker installation was gone!!

So i had to redownload and install like in stackoverflow article above. docker version used 19.03.9

Also to prevent running out of space you need to remap docker's data root see comments below in the above link

```
sudo mkdir -p /volume1/@Docker/lib 
sudo mkdir /docker 
sudo mount -o bind "/volume1/@Docker/lib" /docker. 
```
Then set the data-root in /etc/docker/daemon.json: { "data-root": "/docker" }
