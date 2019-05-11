<html> 
<head><title>Mein Server</title></head> 
<body> 
<?php

echo date('d.m.Y \u\m H:i:s');
echo "<br>";

$ip = getenv("REMOTE_ADDR"); 
echo "Deine IP-Adresse lautet ".$ip;

echo "<br>";

phpinfo();

?> 

</body> 
</html>


