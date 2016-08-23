initialize
setInterpreter: anInterpreter 
	"Note: This is coded so that it can be run in Squeak."

	| ok |
	<export: true>
	<var: #anInterpreter type: #'struct VirtualMachine*'>
	interpreterProxy := anInterpreter.
	ok := interpreterProxy majorVersion = (self cCode: 'VM_PROXY_MAJOR' inSmalltalk: [self majorVersion])
		and: [interpreterProxy minorVersion >= (self cCode: 'VM_PROXY_MINOR' inSmalltalk: [self minorVersion])].
	ok ifTrue:
		[self expandDereferenceInterpreterProxyFunctionTable].
	^ok