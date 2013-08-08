alien functions - tests
ffiTestLongLong8: arguments
	| result alienMethod |
	result :=  Alien new: 8.
	alienMethod := self alienMethodNamed:'ffiTestLongLong8'.
	^ alienMethod primFFICallResult: result
		with: (arguments at:1)
		with: (arguments at:2)
		with: (arguments at:3)
		with: (arguments at:4)
		with: (arguments at:5)
		with: (arguments at:6)
		with: (arguments at:7)
		with: (arguments at:8)
		with: (arguments at:9)
		with: (arguments at:10).
	