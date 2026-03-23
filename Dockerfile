FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV RESOLUTION=1280x720x24

RUN apt-get update && apt-get install -y \
    firefox \
    fluxbox \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    supervisor \
    net-tools \
    bash \
    && apt-get clean

# noVNC index page
RUN ln -sf /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# VNC password (change this!)
RUN mkdir -p /root/.vnc && \
    x11vnc -storepasswd "yourpassword" /root/.vnc/passwd

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 6080

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
