#!/bin/bash

set -e
set -x

yum install -y zeromq

## grrr logstash/java/ruby
cd /usr/lib64
ln -s libzmq.so.1 libzmq.so

cd /tmp/src

mv conf plugins templates /etc/logstash/

mv launch.sh /usr/local/bin/launch-logstash.sh
mv supervisord.conf /etc/supervisor.d/logstash.conf

## cleanup

yum clean all

cd /
rm -rf /tmp/src /var/tmp/yum-root*
