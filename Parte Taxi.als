
sig TaxiDriver {
	taxi: Taxi
}

sig Taxi{
	driver: TaxiDriver,
}
sig TaxiQueue{
	city:CityZone,
	taxis:set Taxi 
}
sig GPS{
	taxi:Taxi,
	coord:Coordinates
}
sig CityZone{

}

sig Coordinates{
}





//FACTS/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

fact sameTaxiSameDriver{
	driver=~taxi
}

fact OneQueueOneZone{
	 no disj c1,c2: TaxiQueue|(c1.city=c2.city) 
}
fact OneGpsOneTaxi{
	 all t1:Taxi|some g1:GPS| (t1 in g1.taxi)
}
fact OneGPSForTaxi{
	all g1,g2:GPS|  all t1:Taxi  |((t1 in g1.taxi)and (t1 in g2.taxi))implies(g1=g2)
}
fact TaxiInQueue{
	all t1:Taxi|some c1:TaxiQueue | (t1 in c1.taxis) 
}
fact TaxiInOneQueue{
	all q1,q2:TaxiQueue |all t1:Taxi |  ((t1 in q1.taxis)and (t1 in q2.taxis))implies(q1=q2)
}
fact coordMess{
	all g1,g2:GPS|all q1,q2:TaxiQueue | ((g1.coord=g2.coord) and (g1!=g2)and(g1.taxi in q1.taxis)and(g2.taxi in q2.taxis))implies(q1=q2)
}






pred show{}


run show  for 5
