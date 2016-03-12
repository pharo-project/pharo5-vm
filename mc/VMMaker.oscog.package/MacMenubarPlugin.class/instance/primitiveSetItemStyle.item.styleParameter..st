system primitives
primitiveSetItemStyle: menuHandleOop item: anInteger styleParameter: chStyleInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveSetItemStyle'
		parameters: #(Oop SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetItemStyle(menuHandle,anInteger,chStyleInteger)' inSmalltalk:[menuHandle].
	^nil

