#! /bin/sh
docker container rm shinobi || /bin/true
docker run -td \
	--restart always \
	-e DEBBASE_SYSLOG=stdout \
	-e DEBBASE_TIMEZONE=`cat /etc/timezone` \
	--stop-signal=SIGRTMIN+3 \
	--tmpfs /run:size=100M \
	--tmpfs /run/lock:size=100M \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	-v ${PWD}/conf.json:/opt/shinobi/conf.json \
	-v ${PWD}/tensorflow-conf.json:/opt/shinobi/plugins/tensorflow/conf.json \
	-p 8082:8082 \
	--network lan-services \
	--name=shinobi-tensorflow-jetson \
	shinobi-tensorflow-jetson
