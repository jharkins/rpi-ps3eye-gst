#!/bin/bash

HOST_IP=192.168.1.138
HOST_PORT=3000
WIDTH=640
HEIGHT=480
QUEUE_BYTES=$((2**24)) # 16mb queues between threads

gst-launch-1.0 \
v4l2src !\
	video/x-raw,width=$WIDTH,height=$HEIGHT,framerate=\(fraction\)30/1 !\
	clockoverlay !\
	queue max-size-bytes=$QUEUE_BYTES !\
	omxh264enc !\
	h264parse !\
	queue max-size-bytes=$QUEUE_BYTES !\
	mux. \
pulsesrc !\
	audioconvert !\
	lamemp3enc target=bitrate bitrate=64 cbr=true !\
	queue max-size-bytes=$QUEUE_BYTES !\
mux. matroskamux name=mux streamable=true !\
tcpserversink port=$HOST_PORT host=$HOST_IP recover-policy=keyframe sync-method=latest-keyframe
