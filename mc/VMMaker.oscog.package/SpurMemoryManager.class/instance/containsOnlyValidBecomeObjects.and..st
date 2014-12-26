become implementation
containsOnlyValidBecomeObjects: array1 and: array2
	"Answer 0 if neither array contains only unpinned non-immediates.
	 Otherwise answer an informative error code.
	 Can't become: immediates!  Shouldn't become pinned objects."
	| fieldOffset effectsFlags oop size |
	fieldOffset := self lastPointerOf: array1.
	effectsFlags := size := 0.
	"same size as array2"
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[oop := self longAt: array1 + fieldOffset.
		 (self isOopForwarded: oop) ifTrue:
			[oop := self followForwarded: oop.
			 self longAt: array1 + fieldOffset put: oop].
		 (self isImmediate: oop) ifTrue: [^PrimErrInappropriate].
		 (self isPinned: oop) ifTrue: [^PrimErrObjectIsPinned].
		 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop).
		 size := size + (self bytesInObject: oop).
		 oop := self longAt: array2 + fieldOffset.
		 (self isOopForwarded: oop) ifTrue:
			[oop := self followForwarded: oop.
			 self longAt: array2 + fieldOffset put: oop].
		 (self isImmediate: oop) ifTrue: [^PrimErrInappropriate].
		 (self isPinned: oop) ifTrue: [^PrimErrObjectIsPinned].
		 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop).
		 size := size + (self bytesInObject: oop).
		 fieldOffset := fieldOffset - self bytesPerOop].
	"only set flags after checking all args."
	becomeEffectsFlags := effectsFlags.
	size >= (totalFreeOldSpace + (scavengeThreshold - freeStart)) ifTrue:
		[^PrimErrNoMemory].
	^0