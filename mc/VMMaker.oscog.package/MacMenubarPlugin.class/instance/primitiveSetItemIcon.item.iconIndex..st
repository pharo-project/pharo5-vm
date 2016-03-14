system primitives
primitiveSetItemIcon: menuHandleOop item: anInteger iconIndex: aIconIndexInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveSetItemIcon'
		parameters: #(Oop SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetItemIcon(menuHandle,anInteger,aIconIndexInteger)' inSmalltalk:[menuHandle].
	^nil

