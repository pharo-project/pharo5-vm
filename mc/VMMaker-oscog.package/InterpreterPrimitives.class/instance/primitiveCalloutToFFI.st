plugin primitives
primitiveCalloutToFFI
	"Perform a function call to a foreign function.
	Only invoked from method containing explicit external call spec.
	Due to this we use the pluggable prim mechanism explicitly here
	(the first literal of any FFI spec'ed method is an ExternalFunction
	and not an array as used in the pluggable primitive mechanism)."

	| primitiveCallout |
	<var: #primitiveCallout declareC: 'void (*primitiveCallout)(void)'>
	primitiveCallout := self functionForPrimitiveCallout.
	primitiveCallout isNil
		ifTrue: [self primitiveFail]
		ifFalse: [self perform: primitiveCallout]