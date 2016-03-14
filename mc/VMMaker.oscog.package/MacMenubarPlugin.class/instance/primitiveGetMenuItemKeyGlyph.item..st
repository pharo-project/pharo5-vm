system primitives
primitiveGetMenuItemKeyGlyph: menuHandleOop item: anInteger 
	<var: #menuHandle type: #MenuHandle>
	<var: #outGlyph type: #SInt16>
	| menuHandle outGlyph |
	self primitive: 'primitiveGetMenuItemKeyGlyph'
		parameters: #(Oop SmallInteger).
	outGlyph := 0.
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'GetMenuItemKeyGlyph(menuHandle,anInteger,&outGlyph)' inSmalltalk:[menuHandle].
	^interpreterProxy positive32BitIntegerFor: outGlyph
	