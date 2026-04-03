Crontab:
```
# Turn screen ON at 08:00
0 8 * * * /usr/local/bin/screen-on.sh

# Turn screen OFF at 17:00
0 17 * * * /usr/local/bin/screen-off.sh
```

Screen on:
```
#!/bin/bash
echo on > /sys/class/drm/card0-DP-1/status
```

Screen off:
```
#!/bin/bash
echo off > /sys/class/drm/card0-DP-1/status
```
