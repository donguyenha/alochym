<?php
 $server_name = "localhost";
 $user_name = "freeswitch";
 $password = "freeswitch";
 $database_name = "freeswitch";
 $connect = mysql_connect($server_name, $user_name, $password) or die("Could not connect: " . mysql_error());
 $db_select = mysql_select_db($database_name, $connect) or die("Not connected : " . mysql_error());

 #check the file POST request from freeswitch to see below http POST method contents
 if($_POST["sip_profile"] == NULL){
  $result = mysql_query("SELECT * FROM sip_trunk");
 }
 else{
  $user=$_POST["user"];
  $result = mysql_query("SELECT * FROM subscriber where username=$user");
 }

 function not_found(){
  echo '<?xml version="1.0" encoding="utf-8"?>' . "\n";
  echo '<document type="freeswitch/xml">' . "\n";
  echo '  <section name="result">' . "\n";
  echo '    <result status="not found"/>' . "\n";
  echo '  </section>' . "\n";
  echo '</document>' . "\n";
 }
#ktra xem sip_profile la internal hay khong
#neu khong thi no la Gateway
  if($_POST["sip_profile"] == NULL){
   echo "testing \n \n";
   echo '<document type="freeswitch/xml">' . "\n";
   echo ' <section name="directory">' . "\n";
   echo '  <domain name="' . $_POST["FreeSWITCH-IPv4"] . '">' . "\n" ;
   echo '   <user id="thm">' . "\n";
   echo '    <gateways>' . "\n";
   while ($mysql_result = mysql_fetch_array($result)){
    echo '     <gateway name="' . $mysql_result['GWname'] . '">' . "\n";
    echo '      <params>' ."\n";
    echo '       <param name="proxy" value="' . $mysql_result['proxy'] . '"/>' . "\n";
    echo '       <param name="username" value="' . $mysql_result['username'] . '"/>' . "\n";
    echo '       <param name="password" value="' . $mysql_result['password'] . '"/>' . "\n";
    echo '       <param name="register" value="' . $mysql_result['register'] . '"/>' . "\n";
    echo '       <param name="retry-seconds" value="' . $mysql_result['retry'] . '"/>' . "\n";
    echo '      </params>' ."\n";
    echo '     </gateway>' . "\n";
   }
   echo '    </gateways>' . "\n";
   echo '   </user>' . "\n";
   echo '  </domain>' . "\n";
   echo ' </section>' . "\n";
   echo '</document>' . "\n";
  }
  else{
   $mysql_result = mysql_fetch_array($result);
   if($mysql_result == NULL){
    not_found();
   }
   else{
    echo '<?xml version="1.0" encoding="utf-8"?>' . "\n";
    echo '<document type="freeswitch/xml">' . "\n";
    echo '  <section name="directory">' . "\n" ;
    echo '    <domain name="' . $_POST['domain']. '">' . "\n" ;
    echo '      <user id="' . $mysql_result['username'] . '">' . "\n" ;
    echo '        <params>' . "\n";
    echo '          <param name="password" value="' . $mysql_result['password'] . '"/>' . "\n" ;
    echo '        </params>' . "\n";
    echo '        <variables>' . "\n";
    echo '          <variable name="toll_allow" value="' . $mysql_result['toll_allow'] . '"/>' . "\n" ;
    echo '          <variable name="user_context" value="' . $mysql_result['context'] . '"/>' . "\n" ;
    echo '        </variables>' . "\n";
    echo '      </user>' . "\n";
    echo '    </domain>' . "\n";
    echo '  </section>' . "\n";
    echo '</document>' . "\n";
   }
  }
?>



CREATE TABLE sip_trunk (
  id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,\
  GWname CHAR(64) DEFAULT '' NOT NULL,\
  proxy CHAR(64) DEFAULT '' NOT NULL,\
  username CHAR(64) DEFAULT '' NOT NULL,\
  password CHAR(25) DEFAULT '' NOT NULL, \
  register CHAR(64) DEFAULT 'false',\
  retry INT(10) DEFAULT 30
) ENGINE=MyISAM;

insert into sip_trunk (GWname, proxy, username, password, register) value ('thm', 'sia-HCM1CA146.fpt.net', '0873002769', 'a0873002769', 'true');
insert into sip_trunk (GWname, proxy, username, password) value ('alochym', '192.168.1.1', '2769', '3002769');

Cac truong can phai co:
	1.	GWname - la ten trunk. nen dat ten goi nho
	2.	proxy - la SIP server ma FS trunking toi
	3.	username - username 
	4.	password - password
	5.	register -  la gia tri true/false: neu true thi FS la SIP client doi voi SIP server