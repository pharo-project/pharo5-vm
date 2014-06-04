message sending
dispatchFunctionPointer: aFunctionPointer

	<var: #aFunctionPointer type: 'void *'>
	self cCode: '((void (*)(void))aFunctionPointer)()'
			inSmalltalk: [self error: 'my simulator should simulate me']