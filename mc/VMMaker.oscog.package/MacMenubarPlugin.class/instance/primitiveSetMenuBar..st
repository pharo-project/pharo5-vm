system primitives
primitiveSetMenuBar: menuHandleOop

	| menuBarHandle |
	self primitive: 'primitiveSetMenuBar'
		parameters: #(Oop).
	self var: 'menuBarHandle' type: 'MenuBarHandle'.
	menuBarHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuBarHandle'.
	self cCode: 'SetMenuBar(menuBarHandle)' inSmalltalk:[menuBarHandle].
	^nil