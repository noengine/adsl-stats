#!/usr/bin/bash
cd /home/simon/GRAPHER/MODEM
# update the RRD databases first
curl -s 'http://10.0.0.138/xslt?PAGE=J03' | awk -f ip.awk | sed -e 's/[^0-9]//g' | awk 'BEGIN{RS="\r";}{printf "N:%d:%d\n",$1,$2};' | xargs -t rrdtool update ip.rrd
curl -s 'http://10.0.0.138/xslt?PAGE=J07' | awk -f ether.awk | sed -e 's/[^0-9]//g' | awk 'BEGIN{RS="\r";}{printf "N:%d:%d:%d:%d:%d:%d\n",$1,$2,$3,$4,$5,$6};' | xargs -t rrdtool update ether.rrd
curl -s 'http://10.0.0.138/xslt?PAGE=J07' | awk -f wlan.awk | sed -e 's/[^0-9]//g' | awk 'BEGIN{RS="\r";}{printf "N:%d:%d:%d:%d:%d:%d\n",$1,$2,$3,$4,$5,$6};' | xargs -t rrdtool update wlan.rrd
sleep 5
# hourly graphs
rrdtool graph ip-hour.png --start -3600 \
             --title "DSL Link IP bytes" \
             DEF:inoctets=ip.rrd:rxbytes:AVERAGE \
             DEF:outoctets=ip.rrd:txbytes:AVERAGE \
             AREA:inoctets#00FF00:"In traffic" \
             LINE1:outoctets#0000FF:"Out traffic"
rrdtool graph ether-hour.png --start -3600 \
             --title "Ethernet bytes" \
             DEF:inoctets=ether.rrd:rxbytes:AVERAGE \
             DEF:outoctets=ether.rrd:txbytes:AVERAGE \
             DEF:inerrors=ether.rrd:rxerrs:AVERAGE \
             DEF:outerrors=ether.rrd:txerrs:AVERAGE \
             AREA:inoctets#00FF00:"In Bytes" \
             LINE1:outoctets#0000FF:"Out Bytes" \
             LINE2:inerrors#FF0000:"In Errors" \
             LINE3:outerrors#AA0000:"Out Errors"
rrdtool graph wlan-hour.png --start -3600 \
             --title "WLAN bytes" \
             DEF:inoctets=wlan.rrd:rxbytes:AVERAGE \
             DEF:outoctets=wlan.rrd:txbytes:AVERAGE \
             DEF:inerrors=wlan.rrd:rxerrs:AVERAGE \
             DEF:outerrors=wlan.rrd:txerrs:AVERAGE \
             AREA:inoctets#00FF00:"In Bytes" \
             LINE1:outoctets#0000FF:"Out Bytes" \
             LINE2:inerrors#FF0000:"In Errors" \
             LINE3:outerrors#AA0000:"Out Errors"
#daily graph
rrdtool graph ip-day.png --start -86400 \
             --title "DSL Link IP bytes" \
             DEF:inoctets=ip.rrd:rxbytes:AVERAGE \
             DEF:outoctets=ip.rrd:txbytes:AVERAGE \
             AREA:inoctets#00FF00:"In traffic" \
             LINE1:outoctets#0000FF:"Out traffic"
rrdtool graph ether-day.png --start -86400 \
             --title "Ethernet bytes" \
             DEF:inoctets=ether.rrd:rxbytes:AVERAGE \
             DEF:outoctets=ether.rrd:txbytes:AVERAGE \
             DEF:inerrors=ether.rrd:rxerrs:AVERAGE \
             DEF:outerrors=ether.rrd:txerrs:AVERAGE \
             AREA:inoctets#00FF00:"In Bytes" \
             LINE1:outoctets#0000FF:"Out Bytes" \
             LINE2:inerrors#FF0000:"In Errors" \
             LINE3:outerrors#AA0000:"Out Errors"
rrdtool graph wlan-day.png --start -86400 \
             --title "WLAN bytes" \
             DEF:inoctets=wlan.rrd:rxbytes:AVERAGE \
             DEF:outoctets=wlan.rrd:txbytes:AVERAGE \
             DEF:inerrors=wlan.rrd:rxerrs:AVERAGE \
             DEF:outerrors=wlan.rrd:txerrs:AVERAGE \
             AREA:inoctets#00FF00:"In Bytes" \
             LINE1:outoctets#0000FF:"Out Bytes" \
             LINE2:inerrors#FF0000:"In Errors" \
             LINE3:outerrors#AA0000:"Out Errors"


#weekly graph
rrdtool graph ip-week.png --start -604800 \
             DEF:inoctets=ip.rrd:rxbytes:AVERAGE \
             DEF:outoctets=ip.rrd:txbytes:AVERAGE \
             AREA:inoctets#00FF00:"In traffic" \
             LINE1:outoctets#0000FF:"Out traffic"


