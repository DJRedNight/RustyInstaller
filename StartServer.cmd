:: DO NOT EDIT THIS LINE
cd %cd%\RustServer

::::::::::::::::::::::::::::::::
:: EDIT BELOW THIS LINE ONLY! ::
::::::::::::::::::::::::::::::::
RustDedicated.exe -batchmode ^
+server.port 28015 ^
+server.level "Procedural Map" ^
+server.seed 1234567 ^
+server.worldsize 4250 ^
+server.maxplayers 2  ^
+server.hostname "Test Server (Procedural)" ^
+server.description "Test Server (Procedural)" ^
+server.url "http://google.com/" ^
+server.headerimage "https://i.imgur.com/cng70HE.png" ^
+server.identity "YourServer" ^
+server.gamemode "vanilla" ^
+server.tags "monthly" ^
+rcon.port 28016 ^
+rcon.password thisisaverystrongpassword ^
+rcon.web 1