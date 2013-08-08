primitives - OS process access
primitiveArgumentAt
	"Answer a string containing the OS process argument at index (an Integer) in the
	argument list."

	| index argCnt argVec sPtr s |
	<export: true>
	<var: 'argCnt' type: 'extern int'>
	<var: 'argVec' type: 'extern char **'>
	<var: 'sPtr' type: 'char *'>
	self cCode: ''
		inSmalltalk: [argCnt := 1].
	index := interpreterProxy stackIntegerValue: 0.
	((index > argCnt) | (index < 1))
		ifTrue:
			[interpreterProxy pop: 2 thenPush: interpreterProxy nilObject]
		ifFalse:
			[sPtr := self cCode: [argVec at: index - 1]
						inSmalltalk: [Smalltalk getSystemAttribute: 0].
			s := self stringFromCString: sPtr.
			interpreterProxy pop: 2 thenPush: s]

