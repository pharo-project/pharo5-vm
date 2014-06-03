system primitives
primitiveGetItemMark: menuHandleOop item: anInteger
	| menuHandle aCharacter |
	<var: 'menuHandle' type: 'MenuHandle'>
	<var: #aCharacter type: 'CharParameter'>
	self primitive: 'primitiveGetItemMark'
		parameters: #(Oop SmallInteger).
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	aCharacter := 0.
	self cCode: 'GetItemMark(menuHandle,anInteger,&aCharacter)' inSmalltalk:[menuHandle].
	^aCharacter asSmallIntegerObj

