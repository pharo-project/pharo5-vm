primitives - OS process access
primitiveGetCurrentWorkingDirectory
	"Answer a string containing the current working directory."

	| cwd cwdString bufferSize incrementBy maxSize buffer |
	<export: true>
	<var: 'buffer' declareC: 'char *buffer'>
	<var: 'cwd' declareC: 'char *cwd'>

	bufferSize := 100.
	incrementBy := 100.
	maxSize := 5000.

	[cwdString := interpreterProxy
		instantiateClass: interpreterProxy classString
		indexableSize: bufferSize.
	buffer := interpreterProxy arrayValueOf: cwdString.
	cwd := self get: buffer cwd: bufferSize. "getcwd(buffer, bufferSize)"
	((cwd == 0)
		and: [bufferSize < maxSize])]
			whileTrue:
				[bufferSize := bufferSize + incrementBy].
	(cwd == 0)
		ifTrue:
			[^ interpreterProxy primitiveFail]
		ifFalse:
			[cwdString := self stringFromCString: cwd.
			interpreterProxy pop: 1; push: cwdString]
