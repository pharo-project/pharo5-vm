execution
postCallArgumentsNumArgs: numArgs "<Integer>" in: memory "<ByteArray|Bitmap>"
	"Answer an argument vector of the requested size after a vanilla
	 ABI call.  On X86 this simply means accessing register arguments.
	 For compatibility with Cog/Slang we answer unsigned values."
	self assert: numArgs <= 4. "Microsoft & System V agree for the first 4 reg args oinly"
	^((CogX64Compiler ABI == #SysV
				ifTrue: [#(rdi rsi rdx rcx r8 r9)]
				ifFalse: [#(rdi rsi r8 r9)]) copyFrom: 1 to: numArgs) collect:
		[:getter|
		self perform: getter]