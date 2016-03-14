system primitives
primitiveGetMenuItemText: menuHandleOop item: anInteger
	| menuHandle size oop ptr aString |
	<var: #menuHandle type: #MenuHandle>
	<var: #aString type: #Str255>
	<var: #ptr type: 'char *'>
	self primitive: 'primitiveGetMenuItemText'
		parameters: #(Oop SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	aString at: 0 put: 0.
	self cCode: 'GetMenuItemText(menuHandle,anInteger,aString)' inSmalltalk:[menuHandle].
	size := self cCode: 'aString[0]' inSmalltalk: [0].
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize:  size.
	ptr := interpreterProxy firstIndexableField: oop.
	0 to: size-1 do:[:i|
		ptr at: i put: (aString at: (i+1))].
	^oop

