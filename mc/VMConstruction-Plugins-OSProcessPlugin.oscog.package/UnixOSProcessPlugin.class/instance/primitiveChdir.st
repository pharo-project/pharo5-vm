primitives - OS process access
primitiveChdir
	"Call chdir(2) to change current working directory to the specified path string. Answer
	nil for success, or errno on failure."

	| path errno |
	<export: true>
	<var: 'path' type: 'char *'>
	<var: 'errno' type: 'extern int'>
	path := self transientCStringFromString: (interpreterProxy stackObjectValue: 0).
	(self chdir: path)
		ifFalse: [interpreterProxy pop: 2; push: interpreterProxy nilObject]
		ifTrue: [interpreterProxy pop: 2; pushInteger: errno]

