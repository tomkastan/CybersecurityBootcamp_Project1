#!/bin/bash
my_states="California,Georgia,Arizona,Hawaii,New Jersey"

IFS=","
for aState in $my_states
do
 if [ $aState = "Hawaii" ]
 then
  echo 'Hawaii is the BEST!'
 else
  echo "I'm not fond of Hawaii.... $aState"
 fi
done

