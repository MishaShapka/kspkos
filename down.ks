run function.
		
	set alt_down to 4000.
	lock steering to retrograde. 
	wait 3.
	lock throttle to 1.
	print "Снижаем переапсис до -20000.".

until ship:orbit:periapsis<-20000. 

	print"Отключаем двигатель.".
	lock throttle to 0. 
	wait 3. 
	start().
	lock Steering to -SHIP:VELOCITY:SURFACE.
	print "Ждем " + alt_down + " метров над body.".

until ship:altitude<alt_down. 
	start().
	print "Раскрываем парашюты и ждем приземления.".
	wait 3.

until ship:status="landed" or ship:status="splashed". 
	print ship:status.