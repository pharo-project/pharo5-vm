execution
postCallArgumentsNumArgs: numArgs "<Integer>" in: memory "<ByteArray|Bitmap>"
	"Answer an argument vector of the requested size after a vanilla
	 ABI call.  On IA32 this typically means accessing stacked arguments
	 beyond the pushed return address and saved frame pointer.
	 For compatibility with Cog/Slang we answer unsigned values."
	^(9 to: numArgs * 4 + 5 by: 4) collect:
		[:i|
		memory unsignedLongAt: self ebp + i bigEndian: false]