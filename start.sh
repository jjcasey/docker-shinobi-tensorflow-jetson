#! /bin/sh
docker container rm shinobi-tensorflow-jetson || /bin/true
docker run -td \
	--restart always \
	-e DEBBASE_SYSLOG=stdout \
	-e DEBBASE_TIMEZONE=`cat /etc/timezone` \
	--stop-signal=SIGRTMIN+3 \
	--tmpfs /run:size=100M \
	--tmpfs /run/lock:size=100M \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	-v ${PWD}/tensorflow-conf.json:/opt/shinobi/plugins/tensorflow/conf.json \
	-v /usr/local/cuda-10.0:/usr/local/cuda-10.0 \
	-v /usr/lib/aarch64-linux-gnu/libcudnn.so.7:/usr/lib/aarch64-linux-gnu/libcudnn.so.7 \
	-p 8082:8082 \
	--network lan-services \
	--runtime nvidia \
	--name=shinobi-tensorflow-jetson \
	shinobi-tensorflow-jetson
