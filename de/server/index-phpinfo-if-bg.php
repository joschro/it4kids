<html> 
<head><title>Mein Server</title></head> 

<?php
$bgColor = dechex(rand(0,16777215));
echo "<body style=\"background-color:#".$bgColor."\">";
echo "Hintergrundfarbe: ".$bgColor;
?>

<p>
<b>Hallo, ich bin eine Webseite!</b>
</p>

<?php
echo date('d.m.Y \u\m H:i:s');
echo "<br><br>";

$ip = getenv("REMOTE_ADDR"); 
echo "Deine IP-Adresse lautet ".$ip."<br>";
if ($ip == "192.168.42.207") echo "<br>Hallo Elias!";
echo "<br>Du benutzt folgenden Browser: ".getenv("HTTP_USER_AGENT");

echo "<br><br>";

#phpinfo();

?> 

</body> 
</html>


