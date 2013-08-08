simulation support
getpid
	"Simulate getpid(2)"
	<doNotGenerate>
	^(Smalltalk classNamed: #OSProcessAccessor)
		ifNotNil: [:ospa| ospa  forThisOSProcess primGetPid]
		ifNil: [0]