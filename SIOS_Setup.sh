#!/bin/bash
  for i in `cat sioshost` ; do ssh -q $i 'hostname;date;sudo sh /mnt/setup' ;done
