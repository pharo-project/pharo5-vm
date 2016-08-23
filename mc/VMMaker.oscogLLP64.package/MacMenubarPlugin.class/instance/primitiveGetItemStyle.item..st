system primitives
primitiveGetItemStyle: menuHandleOop item: anInteger 
	<var: #menuHandle type: #MenuHandle>
	<var: #chStyle type: #Style>
	| menuHandle chStyle |
	self primitive: 'primitiveGetItemStyle'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	chStyle := 0.
	self cCode: 'GetItemStyle(menuHandle,anInteger,&chStyle)' inSmalltalk:[menuHandle].
	^chStyle asSmallIntegerObj

