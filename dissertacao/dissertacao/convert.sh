FROM=UTF-8
TO=ISO-8859-1

mkdir -p tmp

iconv -f $FROM -t $TO $1 > $1.temp
mv $1 tmp/$1
mv $1.temp $1
