system primitives
primitiveSetMenuItemKeyGlyph: menuHandleOop item: anInteger glyph:  inGlyphInteger
	<var: #menuHandle type: #MenuHandle>
	| menuHandle |
	self primitive: 'primitiveSetMenuItemKeyGlyph'
		parameters: #(Oop SmallInteger SmallInteger).
	menuHandle := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: menuHandleOop) to: #MenuHandle.
	(self ioCheckMenuHandle: menuHandle) ifFalse: [^interpreterProxy success: false].
	self cCode: 'SetMenuItemKeyGlyph(menuHandle,anInteger,inGlyphInteger)' inSmalltalk:[menuHandle].
	^nil
	