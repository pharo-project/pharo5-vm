system primitives
primitiveSetMenuBar: menuHandleOop
	<var: #menuBarHandle type: #MenuBarHandle>
	| menuBarHandle |
	self primitive: 'primitiveSetMenuBar'
		parameters: #(Oop).
	menuBarHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuBarHandle.
	self cCode: 'SetMenuBar(menuBarHandle)' inSmalltalk:[menuBarHandle].
	^nil