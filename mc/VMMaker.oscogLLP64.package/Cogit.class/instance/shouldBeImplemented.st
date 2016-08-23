bytecode generator support
shouldBeImplemented
	"In the production VM we can continue in the interpreter..."
	self cCode: [coInterpreter warning: 'bytecode should be implemented; interpreting']
		inSmalltalk: [super shouldBeImplemented]