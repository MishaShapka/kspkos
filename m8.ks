
run function.

//set x to 0.
//until x=2{
//print data().
// }.


lock steering to heading(init()[0],init()[1]).

start().
until ship:orbit:apoapsis>10000{data().}.
until stage:solidfuel<1{data().}. 
	wait 3. 
	start().
	wait 3.
	start(). //Активация ЖРД

run orbit_body.


UNTIL CheckMunAngle()
{
	WAIT 1.
	clearscreen.
}.



print "Transfer start!".

LOCK Steering TO prograde.
WAIT 3.
set the_mun to body("Mun").
UNTIL ORBIT:Apoapsis>(the_mun:Altitude + 10000)
{
	if (orbit:Apoapsis/the_mun:Altitude<0.9)
	{
		Lock Throttle to 1.
	}
	else{
		Lock Throttle to 0.1.
	}	
}

//set SHIP:CONTROL:PILOTMAINTHROTTLE to 0.
lock Throttle to 0. WAIT 1.

//print "Transfer burn complete, We're on the way to Mun!".

UNTIL (Ship:Body=the_mun) and (Ship:Altitude<1000000).
//{
//	WAIT 10.
//}
//print "Deploy antenna".
//TOGGLE LIGHTS.
//WAIT 10.