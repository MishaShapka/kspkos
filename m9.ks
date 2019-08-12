run function.

lock steering to heading(init()[0],init()[1]).

start().
until ship:orbit:apoapsis>10000{data().}.
until stage:solidfuel<1{data().}. 
	wait 3. 
	start().
	wait 3.
	start(). //Активация ЖРД
when ship:altitude>70000 then start().
until eta:apoapsis<20{set warp to 3.}.
	set warp to 0.

run orbit_body.
	print "Программа выполнена".
