# docker-cron
A small Alpine container running cron jobs.

Based on https://github.com/xordiv/docker-alpine-cron, thx!

#### Environment variables:

**CRON_STRINGS** - strings with cron jobs. Use "\n" for newline (Default: undefined)   
**CRON_TAIL** - if defined cron log file will read to *stdout* by *tail* (Default: undefined)   
-> By default cron running in foreground  
**APK_INSTALL** - installs specific Alpine APK's
**PIP_INSTALL** - installs specific Python PIP packages
**PIP3_INSTALL** - installs specific Python3 PIP packages

#### Cron files
- /etc/cron.d - place to mount custom crontab files  

When image will run, files in */etc/cron.d* will copied to */var/spool/cron/crontab*.   
If *CRON_STRINGS* defined script creates file */var/spool/cron/crontab/CRON_STRINGS*  

#### Example crontab file:
```
*/5 * * * * python3 /some-scripts/allow-ip.py >/dev/null 2>&1
*/5 * * * * curl -k https://hc-ping.com/xxxxx-yyyyyyy-zzzzzzzz >/dev/null 2>&1
# end
```

#### Log files
Log file by default placed in /var/log/cron/cron.log 

#### Build it:
```
docker build --no-cache -t MyCompany/cron .
```

#### Run it (example):
```
docker run -d \
  --name="exo-ip-updater" \
  -e 'PIP3_INSTALL=asyncio attrs certifi chardet configparser cs dnspython dnspython3 idna multidict pytz requests setuptools urllib3 yarl' \
  -v /nfs/docker_conf/exo-ip-updater/crontabs:/etc/cron.d \
  -v /nfs/docker_conf/exo-ip-updater/some-scripts:/some-scripts \
MyCompany/cron
```
