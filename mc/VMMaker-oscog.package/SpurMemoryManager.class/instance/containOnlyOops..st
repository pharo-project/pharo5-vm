become implementation
containOnlyOops: array
	"Answer if the array contains only non-immediates. You can't become: immediates!"
	| fieldOffset effectsFlags oop |
	fieldOffset := self lastPointerOf: array.
	effectsFlags := 0.
	"same size as array2"
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[oop := self longAt: array + fieldOffset.
		 (self isImmediate: oop) ifTrue: [^false].
		 (self isForwarded: oop) ifTrue:
			[oop := self followForwarded: oop.
			 self longAt: array + fieldOffset put: oop].
		 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop).
		 fieldOffset := fieldOffset - BytesPerOop].
	"only set flags after checking all args."
	becomeEffectsFlags := effectsFlags.
	^true