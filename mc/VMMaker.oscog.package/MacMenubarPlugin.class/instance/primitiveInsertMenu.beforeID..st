system primitives
primitiveInsertMenu: menuHandleOop beforeID: anInteger
	<var: #menuHandle type: #MenuHandle>
	<var: #anInteger type: #MenuID>
	| menuHandle |
	self primitive: 'primitiveInsertMenu'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'InsertMenu(menuHandle,anInteger)' inSmalltalk:[menuHandle].
	^nil