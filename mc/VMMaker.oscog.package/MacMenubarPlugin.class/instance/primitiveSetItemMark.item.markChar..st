system primitives
primitiveSetItemMark: menuHandleOop item: anInteger markChar: aMarkChar
	<var: #menuHandle type: #MenuHandle>
	<var: #aCharacter type: #CharParameter>
	| menuHandle aCharacter |
	self primitive: 'primitiveSetItemMark'
		parameters: #(Oop SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	aCharacter := aMarkChar.
	self cCode: 'SetItemMark(menuHandle,anInteger,aCharacter)' inSmalltalk:[menuHandle].
	^nil

