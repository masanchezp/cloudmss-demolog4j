#!/bin/sh

# dynamically get the container id into index.html
# echo "<p>Hello World from Cloud MSS Training demo</p>" > /usr/share/nginx/html/index.html
# echo "<p>This container was created on : $(date)</p>" >> /usr/share/nginx/html/index.html
# echo "<p>This container image was built using the automated Cloud MSS Training pipeline - Scan only alerts - AWS EB desde jenkins" >> /usr/share/nginx/html/index.html
# echo "<p>This request was served from container id : $(hostname)</p>" >> /usr/share/nginx/html/index.html

cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>DevOps Essentials Sample App</title>
</head>
<body style="background-color: #1A729D;">
<h1 style="font-family: Courier; color: #434342; font-size: 48px; text-align: center;">
Web de pruebas Demo v3 Ayto Madrid!
</h1>
</body>
</html>
EOF

# start nginx
nginx -g "daemon off;"

