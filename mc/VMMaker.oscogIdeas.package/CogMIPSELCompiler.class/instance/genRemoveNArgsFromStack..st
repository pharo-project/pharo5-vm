abi
genRemoveNArgsFromStack: n
	"This is a no-op on MIPS since the ABI passes up to 4 args in registers and trampolines currently observe that limit."
	self assert: n <= 4.
	^0