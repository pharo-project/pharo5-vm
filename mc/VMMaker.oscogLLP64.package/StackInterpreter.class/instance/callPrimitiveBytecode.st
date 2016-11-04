miscellaneous bytecodes
callPrimitiveBytecode
	"V4:			249		11111001	i i i i i i i i	jjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjjj * 256)
	 SistaV1:	248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 V3/Spur:	139		10001011	i i i i i i i i	jjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjjj * 256)"
	"Note that we simply skip a callPrimitiveBytecode at the start of a method
	 that contains a primitive.  This because methods like Context(Part)>>reset
	 have to be updated to skip the callPrimtiive bytecode otherwise."
	SistaVM
		ifTrue:
			[| byte1 byte2 prim primSet header |
			 byte1 := self fetchByte.
			 byte2 := self fetchByte.
			 self fetchNextBytecode.
			 byte2 < 128 ifTrue:
				[header := objectMemory methodHeaderOf: method.
				 ((self methodHeaderHasPrimitive: header)
				  and: [localIP asUnsignedInteger
						= (self initialPCForHeader: header method: method) + (self sizeOfCallPrimitiveBytecode: header)]) ifTrue:
					[^self].
				 localIP := localIP - 3.
				 ^self respondToUnknownBytecode].
			 prim := byte2 - 128 << 8 + byte1.
			 primSet := prim >> 13 bitAnd: 3.
			 prim := prim bitAnd: 8191.
			 primSet = 0 ifTrue: [
				
				 prim < 1000 ifTrue:
					[^self nullaryInlinePrimitive: prim].

				 prim < 2000 ifTrue:
					[^self unaryInlinePrimitive: prim - 1000].
				
				 prim < 3000 ifTrue:
					[^self binaryInlinePrimitive: prim - 2000].

				 prim < 4000 ifTrue:
					[^self trinaryInlinePrimitive: prim - 3000].
			 ].
		
			LowcodeVM ifTrue: [
				primSet = 1 ifTrue: [
					prim < 1000 ifTrue:
						[^self lowcodeNullaryInlinePrimitive: prim].

					prim < 2000 ifTrue:
						[^self lowcodeUnaryInlinePrimitive: prim - 1000].
				
					prim < 3000 ifTrue:
						[^self lowcodeBinaryInlinePrimitive: prim - 2000].

					prim < 4000 ifTrue:
						[^self lowcodeTrinaryInlinePrimitive: prim - 3000].
				].
			].
		
			localIP := localIP - 3.
			^self respondToUnknownBytecode]
		ifFalse:
			[| header |
			 header := objectMemory methodHeaderOf: method.
			 ((self methodHeaderHasPrimitive: header)
			  and: [localIP asInteger = (self initialPCForHeader: header method: method)])
				ifTrue:
					[localIP := localIP + (self sizeOfCallPrimitiveBytecode: header) - 1.
					 ^self fetchNextBytecode]
				ifFalse:
					[^self respondToUnknownBytecode]]