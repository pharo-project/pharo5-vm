miscellaneous bytecodes
extBBytecode
	"225		11100001	sbbbbbbb	Extend B (Ext B = Ext B prev * 256 + Ext B)"
	(extA = 0 and: [extB = 0]) ifTrue:
		[lastExtPC := localIP].
	^super extBBytecode