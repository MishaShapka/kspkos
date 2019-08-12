//Запуск аппарата к Муне. Нуждается в доработке. Не выводит на орбиту.



run function.

lock steering to heading(init()[0],init()[1]).
start(). 
until ship:orbit:apoapsis>10000{data().}.
until stage:solidfuel<1{data().}. 
	wait 3. 
	start().
	wait 3.
	start(). //Активация ЖРД
//until eta:apoapsis<20{set warp to 3.}.
	//set warp to 0.
run orbit_body.

UNTIL CheckMunAngle()
{
	WAIT 1.
	clearscreen.
}.

	print "Go".
	LOCK Steering TO prograde.
	WAIT 3.
	set the_mun to body("Mun").
UNTIL ORBIT:Apoapsis>(the_mun:Altitude + 50000){
	if (orbit:Apoapsis/the_mun:Altitude<0.9)
	{
		Lock Throttle to 1.
	}
	else{
		Lock Throttle to 0.1.
	}	
}.
	lock Throttle to 0. WAIT 1.

until eta:apoapsis<10.
	lock steering to retrograde. 
	wait 3.
	lock throttle to 1.
	print "Снижаем переапсис до -20000.".

until ship:orbit:periapsis<-20000. 

	print"Отключаем двигатель.".
	lock throttle to 0. 


