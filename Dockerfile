from ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apache2

RUN cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>DevOps Essentials Sample App</title>
</head>
<body style="background-color: #1A729D;">
<h1 style="font-family: Courier; color: #434342; font-size: 48px; text-align: center;">
Web de pruebas Demo v2 para Training desde Pipeline sin malware ni RSA con el nuevo contenedor!
</h1>
</body>
</html>
EOF

#RUN echo 'Hello World!' > /var/www/html/index.html

RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \ 
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \ 
 chmod 755 /root/run_apache.sh

EXPOSE 80

CMD /root/run_apache.sh