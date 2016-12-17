execution
postCallArgumentsNumArgs: numArgs "<Integer>" in: memory "<ByteArray|Bitmap>"
	"Answer an argument vector of the requested size after a Win64 or SysV
	 ABI call.  On X64 this simply means accessing register arguments.
	 For compatibility with Cog/Slang we answer unsigned values."
	self assert: numArgs <= 4.
	^((CogX64Compiler isSysV
				ifTrue: [#(rdi rsi rdx rcx r8 r9)]
				ifFalse: [#(rcx rdx r8 r9)]) copyFrom: 1 to: numArgs) collect:
		[:getter|
		self perform: getter]