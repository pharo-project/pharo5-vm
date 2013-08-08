primitives - OS process access
primitivePutEnv
	"Set an environment variable using a string of the form 'KEY=value'. This
	implementation allocates a C string using malloc to allocate from the C heap
	(using cStringFromString rather than transientCStringFromString). This
	is necessary because the C runtime library does not make a copy of the
	string into separately allocated environment memory."

	| cStringPtr keyValueString |
	<export: true>
	<var: 'cStringPtr' declareC: 'char *cStringPtr'>
	keyValueString := interpreterProxy stackObjectValue: 0.
	cStringPtr := self cStringFromString: keyValueString.
	((self putenv: cStringPtr) == 0)	"Set environment variable."
		ifTrue: [interpreterProxy pop: 2; push: keyValueString]
		ifFalse: [^ interpreterProxy primitiveFail]
