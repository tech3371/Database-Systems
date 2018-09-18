#!/bin/bash


awk '{for(i=2;i<=5;i++) s+=$i;printf($1, $2,"%.1f\n",s/5)}' cryptic.txt
