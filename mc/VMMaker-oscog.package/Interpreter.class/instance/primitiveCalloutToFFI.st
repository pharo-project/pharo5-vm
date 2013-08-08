message sending
primitiveCalloutToFFI
	"Perform a function call to a foreign function.
	Only invoked from method containing explicit external call spec.
	Due to this we use the pluggable prim mechanism explicitly here
	(the first literal of any FFI spec'ed method is an ExternalFunction
	and not an array as used in the pluggable primitive mechanism)."

	| function moduleName functionName |
	<var: #function declareC: 'static void *function = 0'>
	<var: #moduleName declareC: 'static char *moduleName = "SqueakFFIPrims"'>
	<var: #functionName declareC: 'static char *functionName = "primitiveCallout"'>
	function = 0 ifTrue: [
		function := self
			ioLoadExternalFunction: (self oopForPointer: functionName)
			OfLength: 16
			FromModule: (self oopForPointer: moduleName)
			OfLength: 14.
		function == 0 ifTrue: [^self primitiveFail]].
	^self cCode: '((sqInt (*)(void))function)()'.
