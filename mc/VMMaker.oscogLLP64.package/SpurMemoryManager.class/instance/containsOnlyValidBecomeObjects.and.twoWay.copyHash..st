become implementation
containsOnlyValidBecomeObjects: array1 and: array2 twoWay: isTwoWay copyHash: copyHash
	"Answer 0 if neither array contains an object inappropriate for the become operation.
	 Otherwise answer an informative error code for the first offending object found:
		Can't become: immediates => PrimErrInappropriate
		Shouldn't become pinned objects => PrimErrObjectIsPinned.
		Shouldn't become immutable objects => PrimErrNoModification.
		Can't copy hash into immediates => PrimErrInappropriate.
		Two-way become may require memory to create copies => PrimErrNoMemory.
	 As a side-effect unforward any forwarders in the two arrays if answering 0."
	<inline: true>
	| fieldOffset effectsFlags oop1 oop2 size |
	fieldOffset := self lastPointerOf: array1.
	effectsFlags := size := 0.
	"array1 is known to be the same size as array2"
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[oop1 := self longAt: array1 + fieldOffset.
		 (self isOopForwarded: oop1) ifTrue:
			[oop1 := self followForwarded: oop1.
			 self longAt: array1 + fieldOffset put: oop1].
		 self ifOopInvalidForBecome: oop1 errorCodeInto: [:errCode| ^errCode].
		 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop1).
		 oop2 := self longAt: array2 + fieldOffset.
		 (self isOopForwarded: oop2) ifTrue:
			[oop2 := self followForwarded: oop2.
			 self longAt: array2 + fieldOffset put: oop2].
		 isTwoWay
			ifTrue:
				[self ifOopInvalidForBecome: oop2 errorCodeInto: [:errCode| ^errCode].
				 size := size + (self bytesInObject: oop1) + (self bytesInObject: oop2).
				 effectsFlags := effectsFlags bitOr: (self becomeEffectFlagsFor: oop2)]
			ifFalse:
				[(copyHash and: [self isImmediate: oop2]) ifTrue:
					[^PrimErrInappropriate]].
		 fieldOffset := fieldOffset - self bytesPerOop].
	size >= (totalFreeOldSpace + (scavengeThreshold - freeStart)) ifTrue:
		[^PrimErrNoMemory].
	"only set flags after checking all args."
	becomeEffectsFlags := effectsFlags.
	^0