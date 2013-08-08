span functions
parseV4Exts: nExts priorTo: bcpc in: aMethodObj into: aBinaryBlock
	"224		11100000	aaaaaaaa	Extend A (Ext A = Ext A prev * 256 + Ext A)
	 225		11100001	sbbbbbbb	Extend B (Ext B = Ext B prev * 256 + Ext B)"
	| extAValue extBValue pc byte extByte |
	<inline: true>
	extAValue := extBValue := 0.
	pc := bcpc - nExts - nExts.
	[pc < bcpc] whileTrue:
		[byte := objectMemory fetchByte: pc ofObject: aMethodObj.
		 pc := pc + 1.
		 extByte := objectMemory fetchByte: pc ofObject: aMethodObj.
		 pc := pc + 1.
		 self assert: (byte = 224 or: [byte = 225]).
		 byte = 224
			ifTrue:
				[extAValue := (extAValue bitShift: 8) + extByte]
			ifFalse:
				[extBValue := (extBValue = 0 and: [extByte > 127])
							ifTrue: [extByte - 256]
							ifFalse: [(extBValue bitShift: 8) + extByte]]].
	aBinaryBlock value: extAValue value: extBValue