alien functions
ffiPrintString: anAlienCString
	| result alienMethod |
	result :=  Alien new: 4.
	alienMethod := self alienMethodNamed: 'ffiPrintString'.
	alienMethod
		primFFICallResult: result
		with: anAlienCString pointer.		
	^ result			
		
	