#!/usr/bin/env python
# -*- coding: utf-8 -*-
import datetime
import re
import os
import subprocess
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-h_page", "--hostname_page", dest = "hostname_page")
args = parser.parse_args()

curent_time=str(datetime.datetime.now().strftime("%Y-%m-%d_%H:%M:%S_"))
pid=os.getpid()

fweb=open('/usr/TEST_Script/TMP_FILES/web_temp'+curent_time+str(pid)+'.txt', 'w')
web=subprocess.call(["timeout 120 wget -E -H -p -Q300K --user-agent=Mozilla --no-cache --no-cookies --delete-after --timeout=15 --tries=2 "+args.hostname_page+" 2>&1 | grep '\([0-9.]\+ [KM]B/s\)'"], bufsize=0, shell=True, stdout=(fweb))
fweb.close()
fweb=open('/usr/TEST_Script/TMP_FILES/web_temp'+curent_time+str(pid)+'.txt', 'r')
data=fweb.read()
os.remove('/usr/TEST_Script/TMP_FILES/web_temp'+curent_time+str(pid)+'.txt')
speed_temp=re.findall(r's \((.*?)B/s', str(data))
speed_temp_si=re.findall(r's \((.*?) [KM]B/s', str(data))
try:
        if re.findall(r'M', str(speed_temp))==[] and re.findall(r'K', str(speed_temp))==[]:
                speed_="{0:.3f}".format(float(speed_temp_si[0])*0.001*8)
        elif re.findall(r'M', str(speed_temp))!=[]:
                speed_="{0:.3f}".format(float(speed_temp_si[0])*1000*8)
        elif re.findall(r'K', str(speed_temp))!=[]:
                speed_="{0:.3f}".format(float(speed_temp_si[0])*1*8)
except:
        speed_='no_data'
print ('web_speed_test:'+speed_)
