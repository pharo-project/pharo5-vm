primitives - files
primitiveRealpath
	"Answer the real path for a path string as determined by realpath()."

	|  bufferSize pathString newPathString buffer realpathResult s |
	<export: true>
	<var: 'pathString' declareC: 'char *pathString'>
	<var: 'buffer' declareC: 'char *buffer'>
	<var: 'realpathResult' declareC: 'char * realpathResult'>

	bufferSize := 1024.
	newPathString := interpreterProxy
		instantiateClass: interpreterProxy classString
		indexableSize: bufferSize.
	interpreterProxy pushRemappableOop: newPathString.
	pathString := self transientCStringFromString: (interpreterProxy stackObjectValue: 0).
	newPathString := interpreterProxy popRemappableOop.
	buffer := interpreterProxy arrayValueOf: newPathString.
	realpathResult := self cCode: 'realpath(pathString, buffer)' inSmalltalk: [''].
	(realpathResult = 0)
		ifTrue:
			[^ interpreterProxy primitiveFail]
		ifFalse:
			[((self strlen: realpathResult) >= 1024) ifTrue:
				[self perror: 'warning: statically allocated array exceeded in UnixOSProcessPlugin>>primitiveRealPath, object memory may have been corrupted'.
				^ interpreterProxy primitiveFail].
			s := self stringFromCString: realpathResult.
			interpreterProxy pop: 2; push: s]

