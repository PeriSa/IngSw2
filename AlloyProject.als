sig Integer{}
sig Strings{}
abstract sig Person{
	name: Strings,
	surname: Strings
}
sig RegisteredUser extends Person{
	username: Strings,
	password: Strings
}
sig TaxiDriver extends RegisteredUser{
	licenseNumber: Integer,
	taxi: Taxi
}
sig Taxi{
	number: Integer,
	driver: TaxiDriver
}
sig Address{
	address: Strings
}

sig Ride{
	departure: Address,
	destination: Address,
	allocatedTaxi: Taxi,
	user: Person
}
pred show{
	#Taxi>1
	#Person>1
	#Ride>1
}

run show for 2
