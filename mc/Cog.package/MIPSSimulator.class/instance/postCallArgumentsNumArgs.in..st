processor api
postCallArgumentsNumArgs: numArgs "<Integer>" in: memory "<ByteArray|Bitmap>"
	"Answer an argument vector of the requested size after a vanilla ABI call. 
	 We assume that all arguments are single word arguments, which can not be
	 supplied on co-processor-registers. For compatibility with Cog/Slang we answer
	 unsigned values."
	self flag: #OABI.
	
	numArgs = 0 ifTrue: 
		[^{}].
	numArgs = 1 ifTrue: 
		[^{self unsignedRegister: A0}].
	numArgs = 2 ifTrue:
		[^{self unsignedRegister: A0. self unsignedRegister: A1}].
	numArgs = 3 ifTrue:
		[^{self unsignedRegister: A0. self unsignedRegister: A1. self unsignedRegister: A2}].
	numArgs = 4 ifTrue:
		[^{self unsignedRegister: A0. self unsignedRegister: A1. self unsignedRegister: A2. self unsignedRegister: A3}].
	self unimplemented.