generate machine code
concretizePrefetchAw
	"We support only prefetches for addresses that are variables relative to VarBase"
	| operand offset |
	operand := operands at: 0.
	(self isAddressRelativeToVarBase: operand) ifFalse:
		[^machineCodeSize := 0].
	offset := operand - cogit varBaseAddress.
	machineCode
		at: 0 put: 16r0f;
		at: 1 put: 16r18;
		at: 2 put: 16r93;
		at: 3 put: (offset bitAnd: 16rFF);
		at: 4 put: (offset >> 16 bitAnd: 16rFF);
		at: 5 put: (offset >> 8 bitAnd: 16rFF);
		at: 6 put: offset >> 24.
	^machineCodeSize := 7