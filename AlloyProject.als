sig Integer{}
sig Strings{}
abstract sig GeneralUser{
	name: Strings,
	surname: Strings
}
sig RegisteredUser extends GeneralUser{
	username: Strings,
	password: Strings
}
sig TaxiDriver extends RegisteredUser{
	licenseNumber: Integer,
	taxi: Taxi
}
sig Technician extends RegisteredUser{
    id: Integer
}
sig Taxi{
	number: Integer,
	driver: TaxiDriver,
	licensePlate:Strings,
	model:Strings,
	taxiCod:Integer,
	taxiState:Integer	
}
sig Request{
	startingPoint:Address,
	endPoint:Address,
	stimatedTime:Integer,
	waitingTime:Integer
}
sig Reservation extends Request{
	meetingTime:Integer,
	timeOfTheRequest:Integer
}
sig Ride{
	realTime:Integer,
}
sig GPS{
	currentCoordinates:Coordinates
}
sig TaxiQueue{
	queue:some Taxi
}
sig CityZone{
   name: Strings,
	rangeOfCoordinates:some Coordinates
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


pred show{
	#Taxi=1
	#GeneralUser=1
	#Ride=1
	#Request=1
}

run show for 2
