#!/bin/bash
directory="/home/ec2-user"
total_size=$(du -csh "$directory" | grep total | awk '{print $1}')
echo "Total size of files in $directory: $total_size"
