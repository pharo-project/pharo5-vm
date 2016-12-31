initialize
setInterpreter: anInterpreterProxy
	interpreterProxy := anInterpreterProxy.
	actualPlugin setInterpreter: anInterpreterProxy.
	logging ifNil: [logging := false].
	self computeSignatureMap