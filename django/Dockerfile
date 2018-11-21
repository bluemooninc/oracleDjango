FROM centos:centos6.7

ENV container docker

# Local setup
RUN cp -p /etc/localtime /etc/localtime.org
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN cp -p /etc/sysconfig/clock /etc/sysconfig/clock.org
RUN echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock

# yum
RUN yum -y install yum-plugin-ovl
RUN yum -y update
RUN yum -y reinstall glibc-common
RUN yum -y clean all
RUN yum -y install httpd httpd-devel gcc* make tar bzip2 wget which vim
RUN yum -y install m4 dbus file giflib
RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel libaio
RUN yum -y install rsync rsyslog
RUN yum -y install tcp_wrappers tcpdump
RUN yum -y install unzip
RUN yum -y install gcc gcc-c++ make git openssl-devel bzip2-devel zlib-devel readline-devel sqlite-devel bzip2 sqlite
RUN yum -y install zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel
RUN yum -y install python-devel

#ENV HOME /root
#ENV PYENV_ROOT $HOME/.pyenv
#ENV PATH $PYENV_ROOT/bin:$PATH
#RUN git clone git://github.com/yyuu/pyenv.git ~/.pyenv
#RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
#    eval "$(pyenv init -)"
#RUN pyenv install 2.7.15 && \
#    pyenv global 2.7.15

# old pip install
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python

RUN easy_install pip==9.0.3
RUN pip install --upgrade pip

# ssh install
RUN yum -y install openssh-server openssh-clients && \
    mkdir  ~/.ssh && \
    touch  ~/.ssh/authorized_keys && \
    chmod 600  ~/.ssh/authorized_keys

# SSHD
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# install epel
RUN rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6 \
 && yum install -y epel-release

###################
# Install cx_Oracle
###################
RUN mkdir -p /tmp
COPY oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /tmp/
COPY oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm /tmp/
COPY oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /tmp/
ENV ORACLE_HOME /usr/lib/oracle/12.2/client64
ENV ORACLE_SID orcl
ENV LD_RUN_PATH $ORACLE_HOME
ENV LD_LIBRARY_PATH $ORACLE_HOME/lib
ENV PATH=$ORACLE_HOME/bin:$PATH
ENV TNS_ADMIN $ORACLE_HOME/network/admin
RUN cd /tmp && \
    rpm -ivh oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
    rpm -ivh oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm && \
    rpm -ivh oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm && \
    ln -s $LD_LIBRARY_PATH/libclntsh.so.12.1 $LD_LIBRARY_PATH/libclntsh.so && \
    rm *.rpm

#RUN pip install cx_Oracle

RUN mkdir $ORACLE_HOME/network/admin -p
RUN echo "orcl=\
          (DESCRIPTION=\
            (ADDRESS=\
              (PROTOCOL=TCP)(HOST=oracle-container)(PORT=1521)\
            )\
            (CONNECT_DATA =\
              (SERVER=DEDICATED)\
              (SID=orcl)\
              (SERVICE_NAME=pdb1)\
            )\
          )" >> /usr/lib/oracle/12.2/client64/network/admin/tnsnames.ora


# initializing
# RUN chkconfig iptables off
# RUN /etc/init.d/iptables stop
ADD run-kicker.sh /run-kicker.sh
RUN chmod -v +x /run-kicker.sh

# EXPOSE 22 8000

CMD ["/run-kicker.sh"]