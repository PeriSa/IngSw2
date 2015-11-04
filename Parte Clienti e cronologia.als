
sig RegisteredUser {
	history:RideHistory
}
sig Request{
}
sig RideHistory{
	ride:some Ride,
}
sig Ride{
	requ:Request,
	taxi:Taxi,
	history:RideHistory
}
sig Taxi{
}






//FACTS/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


fact  sameHistorySameRide{
	ride=~history
}

fact OneRequestOneRide{
	no disj r1,r2:Ride| (r1.requ=r2.requ)
}

fact HistoryHaveUser{
	all h1:RideHistory|some u1:RegisteredUser| (h1 in u1.history)
}
fact taxiHaveRide{
	all t:Taxi |some r1:Ride| (t in r1.taxi) 
}
fact OneUserOneHistory{
	all u1,u2:RegisteredUser |all h1:RideHistory |  ((h1 = u1.history)and (h1 = u2.history))implies(u1=u2)
}
fact OneRideOneTaxi{
	 all r1:Ride|all h1:RideHistory|some t1:Taxi| (r1 in h1.ride)implies(t1 in  r1.taxi)
}










pred show{#Taxi>4
	#RegisteredUser=3
	#Ride>6
}


run show  for 7
