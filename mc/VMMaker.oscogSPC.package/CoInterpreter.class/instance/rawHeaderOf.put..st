compiled methods
rawHeaderOf: methodOop put: cogMethodOrMethodHeader
	<api>
	"Since methods may be updated while forwarding during become, make the assert accomodate this."
	self assert: (objectMemory isCompiledMethodHeader: (objectMemory headerWhileForwardingOf: methodOop)).
	objectMemory
		storePointerUnchecked: HeaderIndex
		ofObject: methodOop
		withValue: cogMethodOrMethodHeader