system primitives
primitiveSetItemIcon: menuHandleOop item: anInteger iconIndex: aIconIndexInteger
	| menuHandle |
	self primitive: 'primitiveSetItemIcon'
		parameters: #(Oop SmallInteger SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetItemIcon(menuHandle,anInteger,aIconIndexInteger)' inSmalltalk:[menuHandle].
	^nil

