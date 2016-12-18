# rpi-ps3eye-gst
A gststreamer launch bash script and supervisor configuration that allows a Raspberry Pi 3 to use the PS3 Eye to stream audio and video.

## Summary
I wanted to create a cheap baby monitor that was reliable and after a couple evenings fighting with various configurations, I ended up with the shell script and supervisord configuration included. I use gstreamer (which is awesome) and the gst-omx stuff for hardware video encoding on the PI.

I tried using the ALSA stuff for audio, but kept running into an issue with the mixer. I added `snd_usb_audio ignore_ctl_error=1` to `/etc/modules` to try and avoid issues with the alsamixer, which kind of worked, but ultimately delivered extremely poor quality sound. Pulse Audio did the trick and I'm happy with the results there.

For video, I started off playing with `motion` and found that it worked decently for video only. The video for linux stuff worked really well, and I was able to get the video pipe into gst without any crazy work arounds.

I use VLC, both on desktop and mobile phones connected to the network, for monitoring. To connect, I use "Media->Open Network Stream" and the string is `tcp://<ip_address>:<port>` (example: `tcp://192.168.1.30:3000`)

## Setup
1. Get RPI, Raspbian, and the Wireless USB card working.
2. Get the camera working - I used `motion` for initial testing.
3. Copy the `start-gst.sh` script to `/usr/local/bin' and make sure it's executable by the `pi` user.
4. Update the `HOST_IP` and `HOST_PORT` to the settings you want to use.
5. Run the `start-gst.sh` script and install packages that might be missing.
6. Open the stream in VLC using another device on your network - `tcp://<ip_address>:<port>`
7. Shutdown the stream.
8. Install `supervisord`
9. Copy the `start-gst.conf` supervisor configuration to `/etc/supervisor/conf.d/`
10. Reboot!
11. Connect using VLC and `tcp://<ip_address>:<port>`

## Hardware
1. Raspberry Pi 3
2. Wireless USB card (I used Edimax EW-7811Un)
3. PlayStation Eye (PS3 Eye)

## Software
1. Raspbian GNU/Linux 8 - OS
2. Pulse Audio - Only way I found to get decent audio from the RPI3.
3. supervisord - To automagically start gst-launch (via the script).
4. gstreamer1.0 (and assorted gst packages)
5. v4l-utils - I installed video for linux for capturing video off the camera.
