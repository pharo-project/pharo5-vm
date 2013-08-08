printing
printOn: aStream
	aStream nextPutAll: 'an ARMAlien('.
	self registerState allButLast with: self registerStateNames allButLast do: [ :state :i |
		aStream 
			<< i << ': ' 
			<< (state abs > 15 ifTrue: [state hex] ifFalse: [state asString]) 
			<< ', '].
	aStream << 'NZCVIF: ' 
		<< (self registerState last printStringBase: 2 length: 6 padded: true) << ')'.