miscellaneous bytecodes
callPrimitiveBytecode
	"249		11111001	i i i i i i i i	jjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjjj * 256)"
	self error: 'should not be evaluated. method activation should step beyond this bytecode.'
	"We could make it a noop and not skip it in {foo}ActivateMethod, as in:

	localIP := localIP + 3.
	self fetchNextBytecode

	 But for now, having {foo}ActivateMethod skip it makes it available for invoking embedded primitives."