run function.

wait 3.
set x to 0.
until x=7{
	set SciBlock to ship:PARTSTAGGED("sci")[x]. 
	set ScienceModule to SciBlock:GetModule("ModuleScienceExperiment").
	ScienceModule:DEPLOY.
	//ScienceModule:TRANSMIT.
	set x to x+1.
	}. 

	