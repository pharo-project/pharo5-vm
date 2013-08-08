code generation
checkGenerateFieldAccessors: fieldSpecs bitPosition: firstBitPosition in: surrogateClass
	| bitPosition alignedByteSize |
	bitPosition := firstBitPosition.
	fieldSpecs do:
		[:spec| | code |
		"If the accessor is already defined in a superclass don't redefine it in the subclass.
		 We assume it is correctly defined in the superclass."
		(spec first ~= #unused
		 and: [(surrogateClass whichClassIncludesSelector: spec first asSymbol)
				ifNil: [true]
				ifNotNil: [:implementingClass|
						self assert: (implementingClass inheritsFrom: Object).
						implementingClass == surrogateClass]]) ifTrue:
			[code := self getter: spec first
						 bitPosition: bitPosition
						 bitWidth: spec second
						 bool: (spec at: 3 ifAbsent: []) = #Boolean.
			 code ~= (surrogateClass sourceCodeAt: spec first asSymbol ifAbsent: ['']) asString ifTrue:
				[surrogateClass compile: code classified: #accessing].
			 code := self setter: spec first
						 bitPosition: bitPosition
						 bitWidth: spec second
						 bool: (spec at: 3 ifAbsent: []) = #Boolean.
			 code ~= (surrogateClass sourceCodeAt: (spec first, ':') asSymbol ifAbsent: ['']) asString ifTrue:
				[surrogateClass compile: code classified: #accessing]].
		bitPosition := bitPosition + spec second].
	alignedByteSize := bitPosition / 8.
	self assert: alignedByteSize isInteger.
	alignedByteSize ~= surrogateClass alignedByteSize ifTrue:
		[surrogateClass class
			compile: 'alignedByteSize'
					, (String with: Character cr with: Character tab with: $^)
					, alignedByteSize printString
			classified: #accessing]