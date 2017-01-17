code generation
fieldAccessorSourceFor: surrogateClass bytesPerWord: bytesPerWord
	"Answer a Dictionary of MethodReference to source for the accessors of the inst vars of the
	 receiver and the alignedByteSize class method in surrogateClass with the given word size."

	"{CogBlockMethod fieldAccessorSourceFor: CogBlockMethodSurrogate32 bytesPerWord: 4.
	 CogMethod fieldAccessorSourceFor: CogMethodSurrogate32 bytesPerWord: 4.
	 CogBlockMethod fieldAccessorSourceFor: CogBlockMethodSurrogate64 bytesPerWord: 8.
	 CogMethod fieldAccessorSourceFor: CogMethodSurrogate64 bytesPerWord: 8}"
	| methods bitPosition alignedByteSize currentOffset |
	methods := Dictionary new.
	bitPosition := 0.
	(self fieldAccessorsForBytesPerWord: bytesPerWord) do:
		[:spec|
		"reset the bitPosition if the offset expression changes."
		currentOffset ~= (self offsetForInstVar: spec first) ifTrue:
			[bitPosition := 0.
			 currentOffset := self offsetForInstVar: spec first].
		"If the accessor is already defined in a superclass don't redefine it in the subclass.
		 We assume it is correctly defined in the superclass."
		(spec first ~= #unused
		 and: [(surrogateClass whichClassIncludesSelector: spec first asSymbol)
				ifNil: [true]
				ifNotNil: [:implementingClass|
						self assert: (implementingClass inheritsFrom: Object).
						implementingClass == surrogateClass]]) ifTrue:
			[methods
				at: (MethodReference class: surrogateClass selector: spec first asSymbol)
					put: (self getter: spec first
							 bitPosition: bitPosition
							 bitWidth: spec second
							 type: (spec at: 3 ifAbsent: []));
				at: (MethodReference class: surrogateClass selector: (spec first, ':') asSymbol)
					put: (self setter: spec first
							 bitPosition: bitPosition
							 bitWidth: spec second
							 type: (spec at: 3 ifAbsent: []))].
		bitPosition := bitPosition + spec second].
	alignedByteSize := (self roundUpBitPosition: bitPosition toWordBoundary: bytesPerWord) / 8.
	self assert: alignedByteSize isInteger.
	methods
		at: (MethodReference class: surrogateClass class selector: #alignedByteSize)
			put: #alignedByteSize
				, (String with: Character cr with: Character tab with: $^)
				, alignedByteSize printString,
				(currentOffset ifNil: [''] ifNotNil: [' + self ', currentOffset]).
	^methods