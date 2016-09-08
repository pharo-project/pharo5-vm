system primitives
primitiveSetItemCmd: menuHandleOop item: anInteger cmdChar: anIntegerCmdChar
	<var: #menuHandle type: #MenuHandle>
	<var: #aCharacter type: #CharParameter>
	| menuHandle aCharacter |
	self primitive: 'primitiveSetItemCmd'
		parameters: #(Oop SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	aCharacter := anIntegerCmdChar.
	self cCode: 'SetItemCmd(menuHandle,anInteger,aCharacter)' inSmalltalk:[menuHandle].
	^nil

