system primitives
primitiveCheckMenuItem: menuHandleOop item: anInteger checked: aBoolean
	| menuHandle |
	self primitive: 'primitiveCheckMenuItem'
		parameters: #(Oop SmallInteger Boolean).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'CheckMenuItem(menuHandle,anInteger,aBoolean)' inSmalltalk:[menuHandle].
	^nil

