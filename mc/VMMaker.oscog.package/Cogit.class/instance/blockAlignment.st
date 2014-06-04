accessing
blockAlignment
	"Block method headers must be aligned on the correct boundary, just like non-block method headers.
	 This is because the CoInterpreter encodes flags in the least significant three bits of the method field."
	<api>
	<cmacro: '(self) 8'>
	self assert: (methodZone roundUpLength: 1) = 8.
	^8