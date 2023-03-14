FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y lib32z1 xinetd --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m ctf
WORKDIR /home/ctf

RUN mkdir /home/ctf/usr && \
    cp -R /lib* /home/ctf && \
    cp -R /usr/lib* /home/ctf/usr/

RUN mkdir /home/ctf/dev && \
    mknod /home/ctf/dev/null c 1 3 && \
    mknod /home/ctf/dev/zero c 1 5 && \
    mknod /home/ctf/dev/random c 1 8 && \
    mknod /home/ctf/dev/urandom c 1 9 && \
    chmod 666 /home/ctf/dev/*

RUN mkdir /home/ctf/bin && \
    cp /bin/sh /home/ctf/bin && \
    cp /bin/ls /home/ctf/bin && \
    cp /bin/cat /home/ctf/bin && \
    cp /bin/echo /home/ctf/bin && \
 cp /usr/bin/expr /home/ctf/bin

COPY . /
RUN chmod +x /start.sh && \
    mv /xinetd.conf /etc/xinetd.conf && \
    mv /ctf.xinetd /etc/xinetd.d/ctf && \
    mv /src/chall . && \
    mv /src/flag_incomplete.txt . && \
    mv /src/other_half.txt . && \
    chmod +x chall && \
    chmod 555 flag_incomplete.txt && \
    chmod 555 other_half.txt

RUN echo "Blocked by ctf_xinetd" > /etc/banner_fail

EXPOSE 9999

CMD ["/start.sh"]