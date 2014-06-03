become implementation
containsOnlyValidBecomeObjects: array1 and: array2
	"Answer 0 if neither array contains only unpinned non-immediates.
	 Otherwise answer an informative error code.
	 Can't become: immediates!  Shouldn't become pinned objects."
	| fieldOffset effectsFlags oop |
	fieldOffset := self lastPointerOf: array1.
	effectsFlags := 0.
	"same size as array2"
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[oop := self longAt: array1 + fieldOffset.
		 (self isImmediate: oop) ifTrue: [^PrimErrInappropriate].
		 (self isForwarded: oop) ifTrue:
			[oop := self followForwarded: oop.
			 self longAt: array1 + fieldOffset put: oop].
		 (self isPinned: oop) ifTrue: [^PrimErrObjectIsPinned].
		 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop).
		 oop := self longAt: array2 + fieldOffset.
		 (self isImmediate: oop) ifTrue: [^PrimErrInappropriate].
		 (self isForwarded: oop) ifTrue:
			[oop := self followForwarded: oop.
			 self longAt: array2 + fieldOffset put: oop].
		 (self isPinned: oop) ifTrue: [^PrimErrObjectIsPinned].
		 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop).
		 fieldOffset := fieldOffset - BytesPerOop].
	"only set flags after checking all args."
	becomeEffectsFlags := effectsFlags.
	^0