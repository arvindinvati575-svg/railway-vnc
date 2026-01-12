FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    xfce4 xfce4-goodies \
    tigervnc-standalone-server \
    novnc websockify \
    xterm \
    dbus-x11 \
    curl \
    && apt clean

# VNC setup
RUN mkdir -p /root/.vnc
RUN echo '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec startxfce4 &' > /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

EXPOSE 5901

CMD bash -c '\
vncserver :1 -localhost no -SecurityTypes None && \
websockify --web=/usr/share/novnc/ ${PORT} localhost:5901'
