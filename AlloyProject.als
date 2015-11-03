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

sig Taxi{
	driver: TaxiDriver,
	licensePlate:Strings,
	model:Strings,
	taxiCod:Integer,
	taxiState:Integer,
	queue:TaxiQueue
}
sig TaxiQueue{
	city:CityZone,
	taxis:some Taxi
}
sig CityZone{
	name: Strings,
	rangeOfCoordinates: Coordinates,
	queueT:TaxiQueue
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

fact sameTaxiSameDriver{
	driver=~taxi
}

fact TaxiQueueZone{
	city=~queueT
}

fact noStartEqualEnd{
	no r:Request| r.startingPoint=r.endPoint
}

pred show{
	#Taxi=3
	#TaxiQueue=3
}

run show
