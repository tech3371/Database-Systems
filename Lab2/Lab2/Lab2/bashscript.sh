#!/bin/bash


sed 's/[0]/o/g' $1 | sed 's/[4]/a/g' | sed 's/[3]/e/g' | sed 's/[5]/s/g' | sed 's/[7]/t/g'  | sed 's/[1]/i/g' 