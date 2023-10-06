#!/bin/bash

COUNTER=0
while [ $COUNTER -lt 5 ]
do
  echo $COUNTER
  COUNTER=$(( $COUNTER + 1 ))
  sleep 1
done
