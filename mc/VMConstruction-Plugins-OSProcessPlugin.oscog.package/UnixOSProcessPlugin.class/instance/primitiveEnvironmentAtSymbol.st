primitives - OS process access
primitiveEnvironmentAtSymbol
	"Answer the value of an environment variable keyed by a Symbol."

	| getenvResult |
	<export: true>
	<var: 'getenvResult' declareC: 'char * getenvResult'>

	getenvResult := self
		getenv: (self transientCStringFromString: (interpreterProxy stackObjectValue: 0)).
	(getenvResult = 0)
		ifTrue:
			[^ interpreterProxy primitiveFail]
		ifFalse:
			[interpreterProxy pop: 2; push: (self stringFromCString: getenvResult)]

