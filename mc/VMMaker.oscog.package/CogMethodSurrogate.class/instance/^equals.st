comparing
= aCogMethodOrAddressOrNil
	^address = (aCogMethodOrAddressOrNil
					ifNil: [0]
					ifNotNil: [aCogMethodOrAddressOrNil asInteger])