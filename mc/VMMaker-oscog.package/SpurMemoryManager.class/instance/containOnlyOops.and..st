become implementation
containOnlyOops: array1 and: array2
	"Answer if neither array contains only non-immediates. You can't become: immediates!"
	| fieldOffset effectsFlags oop |
	fieldOffset := self lastPointerOf: array1.
	effectsFlags := 0.
	"same size as array2"
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[oop := self longAt: array1 + fieldOffset.
		 (self isImmediate: oop) ifTrue: [^false].
		 (self isForwarded: oop) ifTrue:
			[oop := self followForwarded: oop.
			 self longAt: array1 + fieldOffset put: oop].
		 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop).
		 oop := self longAt: array2 + fieldOffset.
		 (self isImmediate: oop) ifTrue: [^false].
		 (self isForwarded: oop) ifTrue:
			[oop := self followForwarded: oop.
			 self longAt: array2 + fieldOffset put: oop].
		 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop).
		 fieldOffset := fieldOffset - BytesPerOop].
	"only set flags after checking all args."
	becomeEffectsFlags := effectsFlags.
	^true