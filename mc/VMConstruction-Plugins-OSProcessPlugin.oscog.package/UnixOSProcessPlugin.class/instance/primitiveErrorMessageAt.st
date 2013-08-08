primitives - OS process access
primitiveErrorMessageAt
	"Answer a string describing an error message"

	| index errMessage p |
	<export: true>
	<var: 'p' declareC: 'char *p'>

	index := interpreterProxy stackIntegerValue: 0.
	p := self cCoerce: (self cCode: 'strerror(index)' inSmalltalk: ['']) to: 'char *'.
	errMessage := self stringFromCString: p.
	interpreterProxy pop: 2; push: errMessage
