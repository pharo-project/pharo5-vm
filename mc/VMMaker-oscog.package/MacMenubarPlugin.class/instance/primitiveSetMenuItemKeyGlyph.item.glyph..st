system primitives
primitiveSetMenuItemKeyGlyph: menuHandleOop item: anInteger glyph:  inGlyphInteger
	| menuHandle |
	self primitive: 'primitiveSetMenuItemKeyGlyph'
		parameters: #(Oop SmallInteger SmallInteger).
	self var: 'menuHandle' type: 'MenuHandle'.
	
	menuHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'MenuHandle'.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemKeyGlyph(menuHandle,anInteger,inGlyphInteger)' inSmalltalk:[menuHandle].
	^nil
	