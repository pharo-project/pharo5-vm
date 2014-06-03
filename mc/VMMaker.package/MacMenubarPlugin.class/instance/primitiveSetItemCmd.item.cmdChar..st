system primitives
primitiveSetItemCmd: menuHandleOop item: anInteger cmdChar: anIntegerCmdChar
	| menuHandle aCharacter |
	<var: 'menuHandle' type: 'MenuHandle'>
	<var: #aCharacter type: 'CharParameter '>
	self primitive: 'primitiveSetItemCmd'
		parameters: #(Oop SmallInteger SmallInteger).
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	aCharacter := anIntegerCmdChar.
	self cCode: 'SetItemCmd(menuHandle,anInteger,aCharacter)' inSmalltalk:[menuHandle].
	^nil

