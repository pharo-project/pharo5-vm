system primitives
primitiveGetMenuItemKeyGlyph: menuHandleOop item: anInteger 
	| menuHandle outGlyph |
	self primitive: 'primitiveGetMenuItemKeyGlyph'
		parameters: #(Oop SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	self var: 'outGlyph' type: 'SInt16'.
	outGlyph := 0.
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'GetMenuItemKeyGlyph(menuHandle,anInteger,&outGlyph)' inSmalltalk:[menuHandle].
	^interpreterProxy positive32BitIntegerFor: outGlyph
	