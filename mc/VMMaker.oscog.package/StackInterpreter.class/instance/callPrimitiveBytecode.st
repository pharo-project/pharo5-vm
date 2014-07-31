miscellaneous bytecodes
callPrimitiveBytecode
	"V4:			249		11111001	i i i i i i i i	jjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjjj * 256)
	 SistaV1:	248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution."
	self cppIf: SistaVM
		ifTrue:
			[| byte1 byte2 |
			 byte1 := self fetchByte.
			 byte2 := self fetchByte.
			 self fetchNextBytecode.
			 byte2 > 127
				ifTrue:
					[self inlinePrimitiveBytecode: (byte2 bitAnd: 16r7F) << 8 + byte1]
				ifFalse:
					[self error: 'non-inlined callPrimitiveBytecode should not be evaluated. method activation should step beyond this bytecode.']]
		ifFalse:
			[self error: 'callPrimitiveBytecode should not be evaluated. method activation should step beyond this bytecode.']

	"We could make it a noop and not skip it in {foo}ActivateMethod, as in:

	localIP := localIP + 3.
	self fetchNextBytecode

	 But for now, having {foo}ActivateMethod skip it makes it available for invoking embedded primitives."