sig Feature{
	AllowedTechnicians:some Technician,
}

sig Technician{
}

fact Technician{
	some t1:Technician, f1:Feature | (t1 in f1.AllowedTechnicians) 
}


pred show{
	#Technician>1
	#Feature>1	
}

run show  for 5
