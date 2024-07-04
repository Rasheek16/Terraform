#!bin/bash

cat > index.html << EOF
<h1>Hello,world</h1>
<p>DB address:${db_address}</p>
<port>port : ${db_port} </port>
EOF

nohup busybox httpd -f -p ${server_port} &