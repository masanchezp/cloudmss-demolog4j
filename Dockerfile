FROM nginx:1.21.6-alpine

ADD docker-entrypoint.sh /

#Secret exposed
#ADD id_rsa /

#Copy Malware on root directory
#ADD evil /

#Install vulnerable os level packages
#Hashing out as it didn't install it originally....:  CMD apk install  nc
RUN apk add --update --no-cache netcat-openbsd

RUN chmod +x /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
