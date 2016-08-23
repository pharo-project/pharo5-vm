translation support
sizeof: aCType
	<doNotGenerate>
	| bfc |
	aCType == #BytecodeFixup ifTrue:
		[bfc := self class bytecodeFixupClass.
		 ^bfc alignedByteSizeOf: bfc forClient: self].
	^super sizeof: aCType