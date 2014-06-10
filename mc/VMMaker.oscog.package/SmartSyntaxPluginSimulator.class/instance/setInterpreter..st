initialize
setInterpreter: anInterpreterProxy
	interpreterProxy := anInterpreterProxy.
	actualPlugin setInterpreter: anInterpreterProxy.
	self computeSignatureMap