run function.

//Скрипт для достижения первой космической. Циркуляризация орбиты.
lock steering to heading(90,30).
until eta:apoapsis<10{data().}.
	lock throttle to 1. 
	wait 1.
	lock steering to heading(init()[0],math()[3]).
	print "Ждем первой космической.".
	wait 1.

until math[2]<0 {
	if math[2]<100{lock throttle to 0.3.}. 
	if math[2]<50{lock throttle to 0.2.}. 
	if math[2]<10{lock throttle to 0.1.}.
	data().
	}.

	lock steering to heading(90,0).
	lock throttle to 0. 
	print "Достигнута первая космическая".
	wait 3. //Сколько летать по орбите?