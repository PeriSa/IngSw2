sig Integer{}
sig Strings{}//cambiare GeneralUser in User e Registered in Customer
abstract sig GeneralUser{
	name: Strings,
	surname: Strings,
	username: Strings,
	password: Strings
}
sig RegisteredUser {//mettere ereditarietà
	history:RideHistory

}
sig TaxiDriver extends GeneralUser{
	licenseNumber: Integer,
	taxi: Taxi
}
sig Technician{
	id: Integer,
	name: Strings,
	surname: Strings,
	username: Strings,
	password: Strings
}
sig Request{
	startingPoint:Address,
	endPoint:Address,
	stimatedTime:Int,
	waitingTime:Int,
	zone:CityZone,
}
sig RideHistory{
	taxi:set Taxi,
	ride:some Ride,
	user: RegisteredUser
}
sig Ride{
	realTime:Int,
	requ:lone Request,
	taxi:Taxi,
	history:RideHistory
}
sig Reservation extends Request{
	meetingTime:Int,
	timeOfTheRequest:Int
}

sig Taxi{
	driver: TaxiDriver,
	licensePlate:Strings,
	model:Strings,
	taxiCod:Integer,
	taxiState:Int,
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
	name: Strings,
	rangeOfCoordinates: Coordinates,

}

sig Coordinates{
	latitude:Integer,
	longitude:Integer
}
sig Address{
	address: Strings,
	coordinates: Coordinates
}
sig Feature{
	AllowedTechnicians:some Technician,
	Name:Strings,
	Version:Strings
}




///FACTS


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
fact TaxiInQueue{
	some t1:Taxi,c1:TaxiQueue | (t1 in c1.taxis) 
}
fact Time{
	all r1:Request| (r1.stimatedTime>0) and (r1.waitingTime>0)
}
fact Time{
	all r1:Ride| (r1.realTime>0)
}
fact TaxiState{
	all t1:Taxi| (t1.taxiState=0) or (t1.taxiState=1)
}
fact ReservationTime{
	all r1:Reservation | (r1.meetingTime-r1.timeOfTheRequest)>120
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















 pred show{
	#CityZone=3
	#Taxi=5
	#RideHistory=3
	#Ride>1
	#TaxiQueue=3
}


run show  for 5
