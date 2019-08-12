//OSCM4
clearscreen.

function math{
	set Vh to VXCL(Ship:UP:vector, ship:velocity:orbit):mag.	//Считаем горизонтальную скорость
	set Vz to ship:verticalspeed. // это вертикальная скорость
	set Rad to ship:body:radius+ship:altitude. // Радиус орбиты.
	set Vorb to sqrt(ship:body:Mu/Rad). //Это 1я косм. на данной высоте.
	set g_orb to ship:body:Mu/Rad^2. //Ускорение своб. падения на этой высоте.
	set ThrIsp to EngThrustIsp. //EngThrustIsp возвращает суммарную тягу и средний Isp по всем активным двигателям.
	set AThr to ThrIsp[0]*Throttle/(ship:mass). //Ускорение, которое сообщают ракете активные двигатели при тек. массе. 
	set ACentr to Vh^2/Rad. //Центростремительное ускорение.
	set DeltaA to g_orb-ACentr-Max(Min(Vz,2),-2). //Уск своб падения минус центр. ускорение с поправкой на гашение вертикальной скорости.
	set Foo to arcsin(DeltaA/athr).
	set dVh to Vorb-Vh. //Дельта до первой косм.
	return list (Vorb, Vh, Foo).	//Возвращаем лист с данными.
}

FUNCTION EngThrustIsp{
	//создаем пустой лист ens
  set ens to list().
  ens:clear.
  set ens_thrust to 0.
  set ens_isp to 0.
	//запихиваем все движки в лист myengines
  list engines in myengines.
	
	//забираем все активные движки из myengines в ens.
  for en in myengines {
    if en:ignition = true and en:flameout = false {
      ens:add(en).
    }
  }
	//собираем суммарную тягу и Isp по всем активным движкам
  for en in ens {
    set ens_thrust to ens_thrust + en:availablethrust.
    set ens_isp to ens_isp + en:isp.
  }
  //Тягу возвращаем суммарную, а Isp средний.
  return list (ens_thrust).
}

function data{
	clearscreen.
	print "Апоапсис: "+ round(ship:orbit:apoapsis).
	print "Периапсис: "+ round(ship:orbit:periapsis).
	print "Осталось до апоапсиса: "+ eta:apoapsis.
}

function start{
	//print "Ok".
	stage.
}

//------------------------------- end function -------------------------------

start(). wait 1. 
lock steering to heading(100,90).

until stage:solidfuel<1{data().}. 
	wait 3. 
	start().
	print"Ждем Апоапсис.".

//until eta:apoapsis<10{data().}
until ship:altitude>70000{data().}. 
	lock throttle to 1. 
	start().
	wait 1. 
	lock steering to heading(90,math[2]).
	print "Ждем первой космической.".


until math[1]>math[0]. 
	lock throttle to 0. 
	print "Достигнута первая космическая.".
	lock steering to retrograde. 
	wait 10.
	lock throttle to 1.
	print "Снижаем переапсис до -20000.".

until ship:orbit:periapsis<-20000. 
	print"Отключаем двигатель.".
	lock throttle to 0. 
	wait 3. 
	start().
	lock Steering to -SHIP:VELOCITY:SURFACE.
	print "Ждем 4000 метров над body."

until ship:altitude<4000. 
	start().
	print "Раскрываем парашюты и ждем приземления.".
	set warp to 3.
	
until ship:status="landed" or ship:status="splashed". 
	print ship:status.

wait 3.
set x to 0.
until x=3{
	set SciBlock to ship:PARTSTAGGED("sci")[x]. 
	set ScienceModule to SciBlock:GetModule("ModuleScienceExperiment").
	ScienceModule:DEPLOY.
	set x to x+1.
	}. 
print "Ок".
