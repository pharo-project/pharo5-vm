miscellaneous bytecodes
extABytecode
	"224		11100000	aaaaaaaa	Extend A (Ext A = Ext A prev * 256 + Ext A)"
	(extA = 0 and: [extB = 0]) ifTrue:
		[lastExtPC := localIP].
	^super extABytecode