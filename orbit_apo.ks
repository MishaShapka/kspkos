run function.

until ship:altitude>70000{data().}.
	if ship:orbit:apoapsis<init()[2] {lock throttle to 1. start().}.
	print"Ждем апоапсис" + init()[2]. 

until ship:orbit:apoapsis>init()[2] {data().}. lock throttle to 0.

