private
primitiveFreeExternalMemory

	| rcvr memPointer |
	rcvr := self primitive: 'primitiveFreeExternalMemory'
		parameters: #()
		receiver: #FreeTypeExternalMemory.
	self touch: rcvr.
	self var: #memPointer type: 'void*'.
	errorCode := 0.
	"free the memory handle"
	memPointer := self ftHandleValueFromReceiver: rcvr.
	memPointer isNil 
		ifFalse: [self cCode: 'free(memPointer)'].
