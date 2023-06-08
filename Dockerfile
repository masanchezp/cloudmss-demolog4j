from ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apache2

RUN apt-get update

#Log4j not vulnerable
#RUN apt-get install -y liblog4j2-java=2.17.1-0.20.04.1

#Log4j vulnerable
RUN apt-get install -y liblog4j2-java=2.11.2-1

#Secret exposed
ADD id_rsa /

#Copy Malware on root directory
ADD evil /

#"web page"
ADD index.html /var/www/html/index.html

RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \ 
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \ 
 chmod 755 /root/run_apache.sh

EXPOSE 80

CMD /root/run_apache.sh

