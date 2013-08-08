accessing
load
	| address |
	alienHandle notNil ifTrue:[ ^ self ].
	address := self primLoadLibrary: self libraryName.
	alienHandle := Alien new: 4.
	alienHandle unsignedLongAt: 1 put: address.
