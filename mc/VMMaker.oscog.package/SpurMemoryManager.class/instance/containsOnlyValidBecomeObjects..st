become implementation
containsOnlyValidBecomeObjects: array
	"Answer 0 if the array contains only unpinned non-immediates.
	 Otherwise answer an informative error code.
	 Can't become: immediates!  Shouldn't become pinned objects."
	| fieldOffset effectsFlags oop |
	fieldOffset := self lastPointerOf: array.
	effectsFlags := 0.
	"same size as array2"
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[oop := self longAt: array + fieldOffset.
		 (self isImmediate: oop) ifTrue: [^PrimErrInappropriate].
		 (self isForwarded: oop) ifTrue:
			[oop := self followForwarded: oop.
			 self longAt: array + fieldOffset put: oop].
		 (self isPinned: oop) ifTrue: [^PrimErrObjectIsPinned].
		 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop).
		 fieldOffset := fieldOffset - BytesPerOop].
	"only set flags after checking all args."
	becomeEffectsFlags := effectsFlags.
	^0