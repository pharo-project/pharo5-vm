debug support
shortPrint: oop
	| name classOop |
	(objectMemory isImmediate: oop) ifTrue:
		[(objectMemory isImmediateCharacter: oop) ifTrue:
			[^(objectMemory characterValueOf: oop) < 256
				ifTrue:
					['=$' , (objectMemory characterValueOf: oop) printString , 
					' (' , (String with: (Character value: (objectMemory characterValueOf: oop))) , ')']
				ifFalse:
					['=$' , (objectMemory characterValueOf: oop) printString, '(???)']].
		(objectMemory isIntegerObject: oop) ifTrue:
			[^ '=' , (objectMemory integerValueOf: oop) printString , 
			' (' , (objectMemory integerValueOf: oop) hex , ')'].
		^'= UNKNOWN IMMEDIATE', ' (' , (objectMemory integerValueOf: oop) hex , ')'].
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[^(oop bitAnd: objectMemory allocationUnit - 1) ~= 0
			ifTrue: [' is misaligned']
			ifFalse: [self whereIs: oop]].
	(objectMemory isFreeObject: oop) ifTrue:
		[^' is a free chunk of size ', (objectMemory sizeOfFree: oop) printString].
	(objectMemory isForwarded: oop) ifTrue:
		[^' is a forwarded object to ', (objectMemory followForwarded: oop) hex,
			' of slot size ', (objectMemory numSlotsOfAny: oop) printString].
	classOop := objectMemory fetchClassOfNonImm: oop.
	(objectMemory numSlotsOf: classOop) = metaclassNumSlots ifTrue:
		[^'class ' , (self nameOfClass: oop)].
	name := self nameOfClass: classOop.
	name size = 0 ifTrue: [name := '??'].
	name = 'String' ifTrue: [^ (self stringOf: oop) printString].
	name = 'ByteString' ifTrue: [^ (self stringOf: oop) printString].
	name = 'Symbol' ifTrue: [^ '#' , (self stringOf: oop)].
	name = 'ByteSymbol' ifTrue: [^ '#' , (self stringOf: oop)].
	name = 'Character' ifTrue: "SpurMemoryManager has immediate Characters; ObjectMemory does not"
		[^ '=' , (Character value: (objectMemory integerValueOf: 
				(objectMemory fetchPointer: 0 ofObject: oop))) printString].
	name = 'UndefinedObject' ifTrue: [^ 'nil'].
	name = 'False' ifTrue: [^ 'false'].
	name = 'True' ifTrue: [^ 'true'].
	name = 'Float' ifTrue: [^ '=' , (self dbgFloatValueOf: oop) printString].
	(#('Association' 'ReadOnlyVariableBinding' 'VariableBinding') includes: name) ifTrue:
		[^ '(' ,
		(self shortPrint: (self longAt: oop + BaseHeaderSize)) ,
		' -> ' ,
		(self longAt: oop + BaseHeaderSize + BytesPerWord) hex8 , ')'].
	^(('AEIOU' includes: name first) ifTrue: ['an '] ifFalse: ['a ']), name