
abstract sig GeneralUser{

}
sig RegisteredUser {
	history:RideHistory

}
sig TaxiDriver {

	taxi: Taxi
}
sig Technician{

}
sig Request{
	startingPoint:Address,
	endPoint:Address,
	zone:CityZone,
}
sig RideHistory{
	taxi:set Taxi,
	ride:some Ride,
	user: RegisteredUser
}
sig Ride{
	requ:lone Request,
	taxi:Taxi,
	history:RideHistory
}
sig Reservation extends Request{
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
	rangeOfCoordinates: Coordinates,

}

sig Coordinates{

}
sig Address{
	coordinates: Coordinates
}
sig Feature{
	AllowedTechnicians:some Technician,

}




//FACTS/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

fact sameTaxiSameDriver{
	driver=~taxi
}
fact noStartEqualEnd{
	no r:Request| r.startingPoint=r.endPoint
}
fact  sameHistorySameUser{
	user=~history
}
fact  sameHistorySameRide{
	ride=~history
}
fact OneQueueOneZone{
	 no disj c1,c2: TaxiQueue|(c1.city=c2.city) 
}
fact Technician{
	some t1:Technician, f1:Feature | (t1 in f1.AllowedTechnicians) 
}

fact OneGPSForTaxi{
	no disj g1,g2:GPS| (g1.taxi=g2.taxi)
}
fact OneRequestOneRide{
	no disj r1,r2:Ride| (r1.requ=r2.requ)
}
fact OneHistoryOneUser{
	no disj h1,h2:RideHistory| (h1.user=h2.user)
}
fact OneHistoryOneRide{
	no disj h1,h2:RideHistory| (h1.ride=h2.ride) 
}
fact number{
	all r1:RideHistory|(#r1.taxi<=#r1.ride)
}
fact TaxiInQueue{
	all t1:Taxi|some c1:TaxiQueue | (t1 in c1.taxis) 
}
fact TaxiInOneQueue{
	all q1,q2:TaxiQueue |all t1:Taxi |  ((t1 in q1.taxis)and (t1 in q2.taxis))implies(q1=q2)
}
fact oneCoordinateOneZone{
	all z1,z2:CityZone |all c1:Coordinates |  ((c1 = z1.rangeOfCoordinates)and (c1 in z2.rangeOfCoordinates))implies(z1=z2)	
}
fact OneUserOneHistory{
	all u1,u2:RegisteredUser |all h1:RideHistory |  ((h1 = u1.history)and (h1 = u2.history))implies(u1=u2)
}






pred show{
	#CityZone=4
	#Taxi=5
	#TaxiQueue=4
	#RegisteredUser=4
}


run show  for 5



//ASSERTIONS/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

assert noTaxiInMoreCode{
	all q1,q2:TaxiQueue |all t1:Taxi |  ((t1 in q1.taxis)and (t1 in q2.taxis))implies(q1=q2)

}
//check noTaxiInMoreCode for 5

assert noMoreDriver{
	no disj d1,d2:TaxiDriver|d1.taxi=d2.taxi
}
//check noMoreDriver for 5

assert noRideInMoreHistory{
	all h1,h2:RideHistory |all r1:Ride |  ((r1 in h1.ride)and (r1 in h2.ride))implies(h1=h2)
}
//check noRideInMoreHistory for 5
assert noCoordinatesInMoreZone{
	all z1,z2:CityZone |all c1:Coordinates |  ((c1 = z1.rangeOfCoordinates)and (c1 in z2.rangeOfCoordinates))implies(z1=z2)
}
//check noCoordinatesInMoreZone for 5















//PREDICATES/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



pred addRide(r1:Ride,h1, h2 :RideHistory){
	r1 not in h1.ride implies h2.ride=h1.ride+r1
}
//run addRide for 5

pred removeRideIfRequestIsCanceled(r1:Ride,h1, h2 :RideHistory){
		r1 not in h1.ride implies h2.ride=h1.ride-r1
}
//run removeRideIfRequestIsCanceled for 5

pred AtaxiLeaveZone(t:Taxi,q1,q2:TaxiQueue){
	t not in  q1.taxis implies q2.taxis=q1.taxis-t
}
//run AtaxiLeaveZone for 5

pred AtaxiEnterZone(t:Taxi,q1,q2:TaxiQueue){
	t not in  q1.taxis implies q2.taxis=q1.taxis+t
}
//run AtaxiEnterZone for 5

pred TechniciansAllowed(t1:Technician,f1,f2:Feature){
	t1 not in f1.AllowedTechnicians implies f2.AllowedTechnicians=f1.AllowedTechnicians+t1
}
//run TechniciansAllowed for 5

pred TechniciansDenied(t1:Technician,f1,f2:Feature){
	t1 not in f1.AllowedTechnicians implies f2.AllowedTechnicians=f1.AllowedTechnicians-t1
}
//run TechniciansDenied for 5


