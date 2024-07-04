#!bin/bash

cat > index.html << EOF
<h1>Hello,world</h1>
<p>DB address:${}</p>
<port>port : ${} </port>
EOF