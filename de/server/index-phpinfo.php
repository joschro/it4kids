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
echo "Du benutzt folgenden Browser: ".getenv("HTTP_USER_AGENT");
?> 

</body> 
</html>


