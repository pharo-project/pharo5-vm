system primitives
primitiveDisposeMenuBar: menuHandleOop 
	<var: #menuBarHandle type: #Handle>
	| menuBarHandle |
	self primitive: 'primitiveDisposeMenuBar'
		parameters: #(Oop).
	menuBarHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #Handle.
	self cppIf: #'TARGET_API_MAC_CARBON'
		ifTrue: [self cCode: 'DisposeMenuBar(menuBarHandle);' inSmalltalk: [menuBarHandle]]
		ifFalse: [self cCode: 'DisposeHandle(menuBarHandle);' inSmalltalk: [menuBarHandle]].
	^nil
