frame access
isReadMediatedContextInstVarIndex: index
	"Reading the sender, instructionPointer and stackPointer inst vars of a context must take
	 account of potentially married contexts and fetch the state from the frame. method,
	 closureOrNil and receiver can safely be fetched from the context without checking."
	<api>
	<inline: true>
	^index <= StackPointerIndex