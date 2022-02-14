#!/bin/sh

# dynamically get the container id into index.html
# echo "<p>Hello World from Cloud MSS Training demo</p>" > /usr/share/nginx/html/index.html
# echo "<p>This container was created on : $(date)</p>" >> /usr/share/nginx/html/index.html
# echo "<p>This container image was built using the automated Cloud MSS Training pipeline - Scan only alerts - AWS EB desde jenkins" >> /usr/share/nginx/html/index.html
# echo "<p>This request was served from container id : $(hostname)</p>" >> /usr/share/nginx/html/index.html

echo "<!DOCTYPE html>" > /usr/share/nginx/html/index.html
echo "<html>" >> /usr/share/nginx/html/index.html
echo "<head>" >> /usr/share/nginx/html/index.html
echo "<title>DevOps Essentials Sample App</title>" >> /usr/share/nginx/html/index.html
echo "</head>" >> /usr/share/nginx/html/index.html
echo "<body style=&#34;background-color: #1A729D;&#34;>" >> /usr/share/nginx/html/index.html
echo "<h1 style=&#34;font-family: Courier; color: #434342; font-size: 48px; text-align: center;&#34;>" >> /usr/share/nginx/html/index.html
echo "DevOps is TTECH!" >> /usr/share/nginx/html/index.html
echo "</h1>" >> /usr/share/nginx/html/index.html
echo "</body>" >> /usr/share/nginx/html/index.html
echo "</html>" >> /usr/share/nginx/html/index.html

# start nginx
nginx -g "daemon off;"
