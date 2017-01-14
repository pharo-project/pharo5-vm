plugin primitive support
functionForPrimitiveCallout
	"Answer the function primitiveCallout from the FFI plugin or nil if it can't
	 be found.  Cache it for performance.  We use this circumlocution so that
	 Squeak can be deployed without the FFI plugin for security reasons."

	<returnTypeC: 'void (*functionForPrimitiveCallout())(void)'>
	| function |
	<var: #function declareC: 'static void *function = (void *)-1'>
	self cCode: '' inSmalltalk: [function := -1].
	function asInteger = -1 ifTrue:
		[function := self ioLoadFunction: 'primitiveCallout' From: 'SqueakFFIPrims'].
	^self cCoerceSimple: function to: #'void (*)(void)'