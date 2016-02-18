abi
genRemoveNArgsFromStack: n
	"This is a no-op on x64 since the ABI passes up to 6 args in registers and trampolines currently observe a limit of 4."
	self assert: n <= 6.
	^0