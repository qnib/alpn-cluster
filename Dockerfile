FROM qnib/alpn-openmpi

ADD ssh/ /root/.ssh/
RUN apk update && apk upgrade && \
    apk add sed openssh && \
    ln -s /etc/init.d/sshd /etc/runlevels/default/ && \
    sed -i -e 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config && \
    sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    ####### Highly unsecure... !1!! ###########
    echo "        StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "        UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config && \
    echo "        AddressFamily inet" >> /etc/ssh/ssh_config && \
    addgroup -g 3000 clusers && \
    adduser -u 3001 -G clusers -h /home/alice -D -s /bin/bash alice && \
    adduser -u 3002 -G clusers -h /home/bob -D -s /bin/bash bob && \
    adduser -u 3003 -G clusers -h /home/carol -D -s /bin/bash carol && \
    adduser -u 3004 -G clusers -h /home/dave -D -s /bin/bash dave && \
    adduser -u 3005 -G clusers -h /home/eve -D -s /bin/bash eve && \
    addgroup -g 4000 guests && \
    adduser -u 4001 -G guests -h /home/john -D -s /bin/bash john && \
    adduser -u 4002 -G guests -h /home/jane -D -s /bin/bash jane && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/id_rsa.pub && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    sed -i -e 's#^root.*#root:x:0:0:root:/root:/bin/bash#' /etc/passwd && \ 
    apk del sed && \
    rm -rf /var/cache/apk/*
    

