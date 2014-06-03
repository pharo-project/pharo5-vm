system primitives
primitiveSetItemMark: menuHandleOop item: anInteger markChar: aMarkChar
	| menuHandle aCharacter |
	<var: 'menuHandle' type: 'MenuHandle'>
	<var: #aCharacter type: 'CharParameter '>
	self primitive: 'primitiveSetItemMark'
		parameters: #(Oop SmallInteger SmallInteger).
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	aCharacter := aMarkChar.
	self cCode: 'SetItemMark(menuHandle,anInteger,aCharacter)' inSmalltalk:[menuHandle].
	^nil

