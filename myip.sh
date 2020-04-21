
  #!/bin/sh
  ifconfig | grep -oq  "\baddr\b"
  ex=$?
  if [ $ex -eq 0  ]; then
  input="$(ifconfig | grep "inet")"

  input=`printf "$input" |tr -d 'addr:'`

  printf "$input"  |  sed 's/inet /inet:./g' |
  grep -Eo  "inet:(\.[[:digit:]]{1,3}){4}"  |
  grep -v "127" |
  grep -v "\.1$"|
  sed 's/:./:/'

  else
  ifconfig |  sed 's/inet /inet:./g' |
  grep -Eo  "inet:(\.[[:digit:]]{1,3}){4}"  |
  grep -v "127" |
  grep -v "\.1$"|
  sed 's/:./:/'
  fi



  
