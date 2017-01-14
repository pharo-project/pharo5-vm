object map
methodClassOf: methodOop
	^self oopForObject: (self objectForOop: methodOop) methodClass