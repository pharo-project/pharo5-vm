system primitives
primitiveGetItemCmd: menuHandleOop item: anInteger
	| menuHandle aCharacter |
	<var: #menuHandle type: #MenuHandle>
	<var: #aCharacter type: #CharParameter>
	self primitive: 'primitiveGetItemCmd'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	aCharacter := 0.
	self cCode: 'GetItemCmd(menuHandle,anInteger,&aCharacter)' inSmalltalk:[menuHandle].
	^aCharacter asSmallIntegerObj

