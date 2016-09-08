system primitives
primitiveEnableMenuCommand: menuHandleOop item: anInteger
	<var: #menuHandle type: #MenuHandle>
	<var: #commandID type: #MenuCommand>
	| menuHandle commandID |
	self primitive: 'primitiveEnableMenuCommand'
		parameters: #(Oop Oop).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	commandID := self cCoerce: (interpreterProxy positive32BitValueOf: anInteger) to: #MenuCommand.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cppIf: #'TARGET_API_MAC_CARBON'
		ifTrue: [self cCode: 'EnableMenuCommand(menuHandle,commandID);' inSmalltalk: [menuHandle]].
	^nil