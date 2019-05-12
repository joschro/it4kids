<html> 
<head><title>Mein Server</title></head> 

<p>
<b>Hallo, ich bin eine Webseite!</b>
</p>

<?php
echo date('d.m.Y \u\m H:i:s');
echo "<br><br>";

$ip = getenv("REMOTE_ADDR"); 
echo "Deine IP-Adresse lautet ".$ip."<br><br>";
if ($ip == "192.168.42.207") echo "Hallo Elias!<br><br>";
echo "Du benutzt folgenden Browser: ".getenv("HTTP_USER_AGENT");

?> 

</body> 
</html>


