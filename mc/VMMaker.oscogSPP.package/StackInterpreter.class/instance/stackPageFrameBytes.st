stack pages
stackPageFrameBytes
	"Answer a byte size that accomodates a useful number of frames.  The minimum frame size is
	 7 slots in the StackInterpreter, and 6 slots in the CoInterpreter, and the maximum size is 56 + 7
	 slots in the StackInterpreter and 56 + 8 slots in the CoInterpreter. 256 slots gives from 4 to 36
	 frames in the StackInterpreter and from 4 to 42 in the CoInterpreter. Hence 2048 bytes in 32-bits
	 and 4096 bytes in 64-bits; a compromise between overflow rate and latency in divorcing a page."
	"Defining as a macro simplifies hand editing the C for experiments..."
	<cmacro: '() (256 * BytesPerWord)'>
	^256 * objectMemory wordSize