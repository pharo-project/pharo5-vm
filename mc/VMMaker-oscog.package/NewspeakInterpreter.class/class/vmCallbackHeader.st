translation
vmCallbackHeader
	^String streamContents:
		[:s|
		s nextPutAll: '#define VM_CALLBACK_INC 1'; cr; cr.
		VMCallbackContext printTypedefOn: s.
		s cr]