#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: $0 <domain> "
  exit 1
fi
if [ -f "/var/log/httpd/domains/$1.log" ]
then
echo "Logs started on $(head -1 /var/log/httpd/domains/$1.log | cut -d [ -f 2 | cut -d] -f1 | cut -d: -f1)"
echo $(tput setaf 4)"Top 10 page loads"$(tput setaf 7)
cat /var/log/httpd/domains/$1.log | cut -d'"' -f2 | cut -f2 -d' ' | sort | uniq -c | sort -n | tail -10
echo $(tput setaf 4)"Top 10 IP addresses"$(tput setaf 7)
cat /var/log/httpd/domains/$1.log | cut -d- -f1 | sort | uniq -c | sort -n | tail -10
else
echo "The domain is not on the server. Check spelling."
fi
