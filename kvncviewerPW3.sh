 #!/bin/sh
 cd $(dirname "$0")
 LD_LIBRARY_PATH=.
 export LD_LIBRARY_PATH
 
refresh(){
 while :
 do
   eips ''
   usleep 80000
 done
}

leave(){
  echo 'bye bye'
  lipc-set-prop com.lab126.powerd preventScreenSaver 0
  lipc-set-prop com.lab126.winmgr orientationLock $orient
  pkill kindlevncviewer
  exit
}

orient=`lipc-get-prop com.lab126.winmgr orientationLock`
echo "orientiation is $orient"

trap leave SIGINT
lipc-set-prop com.lab126.powerd preventScreenSaver 1
lipc-set-prop com.lab126.winmgr orientationLock R
sleep 3 # give a rest to change orientation

./kindlevncviewer -config config.lua "$@" &
refresh


