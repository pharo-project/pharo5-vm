simulation support
getppid
	"Simulate getppid(2)"
	<doNotGenerate>
	^(Smalltalk classNamed: #OSProcessAccessor)
		ifNotNil: [:ospa| ospa  forThisOSProcess primGetPPid]
		ifNil: [0]