execution
postCallArgumentsNumArgs: numArgs "<Integer>" in: memory "<ByteArray|Bitmap>"
	"Answer an argument vector of the requested size after a vanilla
	 ABI call. For ARM the Procedure Calling Specification can be found in IHI0042D_aapcs.pdf.
	On ARM this typically means accessing r0 through r3 and fetching additional arguments from the stack, acording to pages 20f. aapcs.
	We assume that all arguments are single word arguments, which can not be supplied on co-processor-registers.
	 For compatibility with Cog/Slang we answer unsigned values."
	^(1 to: numArgs) collect: [:i |
		i < 5 
			ifTrue: [self perform: (self registerStateGetters at: i)]
			"ARM uses a full descending stack. Directly after calling a procedure, nothing but the arguments are pushed."
			ifFalse: [memory unsignedLongAt: self sp + (i-5)*4 bigEndian: false]].