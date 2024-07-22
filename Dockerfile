FROM ubuntu:latest

RUN apt update -y
RUN apt upgrade -y

RUN apt-get update && \
    apt-get install -y tmate && \
    echo 'root:root' | chpasswd && \
    printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
    printf "systemctl start systemd-logind" >> /etc/profile

# Create a script to start tmate
RUN printf "#!/bin/bash\n\
tmate -S /tmp/tmate.sock new-session -d\n\
tmate -S /tmp/tmate.sock wait tmate-ready\n\
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}' > /tmp/tmate-ssh\n\
tmate -S /tmp/tmate.sock display -p '#{tmate_web}' > /tmp/tmate-web\n\
cat /tmp/tmate-ssh\n\
cat /tmp/tmate-web\n\
tail -f /dev/null" > /usr/local/bin/start-tmate.sh && chmod +x /usr/local/bin/start-tmate.sh

# Start tmate
CMD ["/usr/local/bin/start-tmate.sh"]
