memory access
checkedLongAt: byteAddress
	"Assumes zero-based array indexing."
	<api>
	(self isInMemory: byteAddress) ifFalse:
		[self warning: 'checkedLongAt bad address'.
		 coInterpreter primitiveFail].
	^self longAt: byteAddress