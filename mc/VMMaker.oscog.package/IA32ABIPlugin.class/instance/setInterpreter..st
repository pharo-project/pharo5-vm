initialize
setInterpreter: anInterpreter 
	"Note: This is coded so that is can be run from Squeak."
	| ok |
	<export: true>
	<var: #anInterpreter type: #'struct VirtualMachine*'>
	interpreterProxy := anInterpreter.
	ok := interpreterProxy majorVersion = 1
			and: [interpreterProxy minorVersion >= 12].
	ok ifTrue:
		[self expandDereferenceInterpreterProxyFunctionTable].
	^ok