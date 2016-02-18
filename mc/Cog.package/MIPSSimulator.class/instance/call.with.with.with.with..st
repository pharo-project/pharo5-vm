as yet unclassified
call: entryPC with: arg0 with: arg1 with: arg2 with: arg3.
	
	pc := entryPC.
	self unsignedRegister: RA put: EndSimulationPC.
	self signedRegister: A0 put: arg0.
	self signedRegister: A1 put: arg1.
	self signedRegister: A2 put: arg2.
	self signedRegister: A3 put: arg3.
	
	self execute.
	
	^self signedRegister: V0.