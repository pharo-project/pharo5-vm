primitives - OS process access
primitiveGetEnvironmentStrings
	"Answer the environment block in the form of an Array of Strings. The
	caller is expected to parse the strings into a dictionary of keys and values."

	| pVarBlock p envArray count string |
	<export: true>
	<var: 'pVarBlock' type: 'TCHAR *'>
	<var: 'p' type: 'TCHAR *'>
	pVarBlock := self GetEnvironmentStrings.

	"Count the environment strings so the result array can be pre-allocated.
	This minimizes the number of objects which must be pushed onto the
	stack of remappable objects."
	p := pVarBlock.
	count := 0.
	[self cCode: '*p != 0' inSmalltalk: [pVarBlock ~= nil]] whileTrue:
		[count := count + 1.
		[self cCode: '*p != 0' inSmalltalk: [p ~= nil]] whileTrue: [p := p + 1].
		p := p + 1].
	"Allocate an array for the strings."
	envArray := interpreterProxy
		instantiateClass: interpreterProxy classArray
		indexableSize: count.
	"Populate the array."
	p := pVarBlock.
	count := 0.
	[self cCode: '*p != 0' inSmalltalk: [pVarBlock ~= nil]] whileTrue:
		[count := count + 1.
		interpreterProxy pushRemappableOop: envArray.
		string := self stringFromCString: p.	"May trigger garbage collection"
		envArray := interpreterProxy popRemappableOop.
		interpreterProxy stObject: envArray at: count put: string.
		[self cCode: '*p != 0' inSmalltalk: [p ~= nil]] whileTrue: [p := p + 1].
		p := p + 1].
	self FreeEnvironmentStrings: pVarBlock.
	interpreterProxy pop: 1 thenPush: envArray