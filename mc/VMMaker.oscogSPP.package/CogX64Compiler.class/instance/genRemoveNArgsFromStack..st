abi
genRemoveNArgsFromStack: n
	"This is a no-op on x64 SysV since the ABI passes up to 6 args in registers and trampolines currently observe a limit of 4.
	But the WIN64 ABI allways reserve shadow space for saving up to 4 parameter registers (even if less than 4 args)."
	self assert: n <= 4.
	SysV ifFalse: [cogit AddCq: 32 R: RSP].
	^0