FROM ubuntu:16.04
RUN echo 'start build' \
# if you are not in China,delete the following two lines
    && sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt update \
    && apt --no-install-recommends install wget -y \
    && wget http://soft.vpser.net/lnmp/lnmp1.7.tar.gz -cO lnmp1.7.tar.gz && tar zxf lnmp1.7.tar.gz && cd lnmp1.7 \
    && sed -i 's/gcc-c++/g++/g' include/init.sh \
    && sed -i 's/Echo_Green "Install lnmp V${LNMP_Ver} completed! enjoy it."/kill -KILL $$/g' include/end.sh \
    && ./install.sh lnmp \
# The default mysql password is "root".Change it to your password if you want
    || sed -i 's/DB_Root_Password=""/DB_Root_Password="root"/g' tools/reset_mysql_root_password.sh \
    && sed -i 's/    read/#    read/g' tools/reset_mysql_root_password.sh \
    && apt --no-install-recommends install openssh-server -y \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config \
    && cd ../ \
    && rm -rf lnmp1.7.tar.gz lnmp1.7 lnmp-install.log \
    && mkdir ~/.ssh \
    && touch ~/.ssh/authorized_keys \
    && apt remove gcc g++ make cmake autoconf automake wget cpp -y \
    && apt clean \
    && apt autoclean \
    && apt autoremove -y \
    && dpkg -l | grep ^rc | awk '{print $2}' | xargs dpkg -P \
    && /etc/init.d/ssh restart \
    && lnmp restart \
    && lnmp status \
    && lnmp stop

# The default root password is "root".Change the second "root" to your password if you want
CMD /etc/init.d/ssh start && echo "root:root" | chpasswd && lnmp restart && lnmp status && tail -f /var/log/wtmp
