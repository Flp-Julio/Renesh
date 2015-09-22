##Script que verifica renegotiation no SSL/TLS
echo
echo -e "			   \033[01;37m[#######]  Renegotiation SSL/TLS PoC  [#######]\033[m"
echo
echo -e "\033[01;34mVerificando renegotiation com OpenSSL em \033[01;32m $1\033[01;37m...\033[m"
sleep 1
echo -e "\033[01;34mEstabelecendo conexão\033[01;37m...\033[m"
sleep 2
echo -e "\033[01;34mEfetuando tentativa de renegotiation\033[01;37m...\033[m"
GET="GET / HTTP/1.0"
R1="R"
for Si in $1; do
(sleep 1
echo -ne "$GET \x0A" 
echo -ne  "\x0A"
	sleep 1
echo -ne "$R1 \x0A"
echo -ne "\x0A"
echo -ne "\x0A"
echo -ne "\x0A"
echo -ne "\x0A"
echo -ne "\x0A"
echo -ne "\x0A"
echo -ne "\x0A"
	sleep 3
) | openssl s_client -CApath /usr/lib/ssl -connect $1  2>&1&> /tmp/renepoc.txt 
done

echo -e "\033[01;34mResultado\033[01;37m:\033[m"
	if grep -q "200 OK" /tmp/renepoc.txt ; then
	    echo -e "\033[01;31m[+]\033[01;37mSERVIDOR VULNERAVEL!\033[01;31m[+]"
	else
	    echo -e "\033[01;32m[+]\033[01;37mSERVIDOR NAO VULNERAVEL!\033[01;32m[+]"
	fi
rm -rf /tmp/renepoc.txt

##Por Luiz F S Julio
##Esse script faz uso do SSLScan https://www.titania.com - http://sourceforge.net/projects/sslscan
##Esse script faz uso do OpenSSL https://www.openssl.org
