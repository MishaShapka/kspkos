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
	return list (Vorb, Vh, dVh, foo).	//Возвращаем лист с данными.
}

function Fo{
	math().
	set Foo to arcsin(DeltaA/athr).
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
	print "Осталось до апоапсиса: "+ round(eta:apoapsis).
	print "------".
	print "Периапсис: "+ round(ship:orbit:periapsis).
	print "------".
	//print "1ая космическая: " + round(math()[0]).
	//print "Осталось дельты до 1ой космической: " + round(math()[2]).
	//print "------".
	wait 0.1.
}

function math_data{
	print math()[0].
}

function start{
	//print "Ok".
	stage.
}

function init{
	set roll to 90. //Задаем крен.
	set pitch to (70000-ship:altitude)/1000. //Задаем тангаж.
	set apo to 11000000. //Задается необходимый апоапсис.
	return list (roll, pitch, apo).	
}

FUNCTION CheckMunAngle
{
	set VecS to Ship:position-body("Kerbin"):position.
	set VecM to body("Mun"):position-body("Kerbin"):position.
	set VecHV to VXCL(ship:up:vector, ship:velocity:orbit).
	set VecSM to body("Mun"):position-Ship:position.
	set m_angle to CalculateMunAngle.
	set cur_angle to VANG(VecM,VecS).
	if VANG(VecHV,VecSM)>90
		set cur_angle to -cur_angle.
	print "Munar angle: " + m_angle.
	print "Current angle: " + cur_angle.
	return ABS(cur_angle - m_angle) < 3.
}

function CalculateMunAngle
{
	SET A1 to (2*body("Kerbin"):radius + body("Mun"):altitude + ship:altitude)/2.
	SET A2 to body("Kerbin"):radius+body("Mun"):altitude.
	return 180*(1 - (A1/A2)^1.5).
}