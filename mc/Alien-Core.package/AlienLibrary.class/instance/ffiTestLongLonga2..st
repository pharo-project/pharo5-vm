alien functions - tests
ffiTestLongLonga2: arguments
	| result alienMethod |
	result :=  Alien new: 8.
	alienMethod := self alienMethodNamed:'ffiTestLongLonga2'.
	^ alienMethod primFFICallResult: result
		with: (arguments at:1)
		with: (arguments at:2)
		with: (arguments at:3)
		with: (arguments at:4).

	