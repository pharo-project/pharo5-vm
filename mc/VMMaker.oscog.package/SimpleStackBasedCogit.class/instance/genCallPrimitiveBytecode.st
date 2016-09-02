bytecode generators
genCallPrimitiveBytecode
	"V3PlusClosures:	139 10001011	iiiiiiii   jjjjjjjj  Call Primitive #iiiiiiii + (jjjjjjjj * 256)
	 NewsqueakV4:		249 11111001	iiiiiiii   jjjjjjjj  Call Primitive #iiiiiiii + (jjjjjjjj * 256)
	 SistaV1:			248 11111000 iiiiiiii mjjjjjjj  Call Primitive #iiiiiiii + ( jjjjjjj * 256)
							m=1 means inlined primitive, no hard return after execution."
	bytecodePC ~= initialPC ifTrue:
		[^EncounteredUnknownBytecode].
	byte2 < 128 ifFalse: [^EncounteredUnknownBytecode].
	self assert: (primitiveIndex = (byte1 + (byte2 << 8))
				or: [primitiveIndex = 0 "disabled primitives, e.g. stream prims"
					and: [(coInterpreter primitiveIndexOf: methodObj) = (byte1 + (byte2 << 8))]]).
	^0