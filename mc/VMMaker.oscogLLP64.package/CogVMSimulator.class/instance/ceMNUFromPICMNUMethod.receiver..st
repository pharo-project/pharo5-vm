trampolines
ceMNUFromPICMNUMethod: aMethodObj receiver: rcvr
	| cPIC |
	cPIC := self cCoerceSimple: self stackTop - cogit mnuOffset to: #'CogMethod *'.
	self assert: (cPIC cmType = CMClosedPIC or: [cPIC cmType = CMOpenPIC]).
	self mnuBreakpoint: cPIC selector receiver: nil.
	^super ceMNUFromPICMNUMethod: aMethodObj receiver: rcvr