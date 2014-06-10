debug printing
printOopShortInner: oop
	| classOop name nameLen |
	<var: #name type: #'char *'>
	<inline: true>
	self printChar: $=.
	(self isIntegerObject: oop) ifTrue:
		[self printNum: (self integerValueOf: oop);
			printChar: $(;
			printHex: (self integerValueOf: oop);
			printChar: $).
		 ^nil].
	(oop between: self startOfMemory and: freeBlock) ifFalse:
		[self printHex: oop; print: ' is not on the heap'.
		 ^nil].
	(oop bitAnd: (BytesPerWord - 1)) ~= 0 ifTrue:
		[self printHex: oop; print: ' is misaligned'.
		 ^nil].
	(self isFloatObject: oop) ifTrue:
		[self printFloat: (self dbgFloatValueOf: oop).
		 ^nil].
	classOop := self fetchClassOf: oop.
	(self sizeBitsOf: classOop) = metaclassSizeBits ifTrue:
		[self printNameOfClass: oop count: 5.
		 ^nil].
	oop = self nilObject ifTrue: [self print: 'nil'. ^nil].
	oop = self trueObject ifTrue: [self print: 'true'. ^nil].
	oop = self falseObject ifTrue: [self print: 'false'. ^nil].
	nameLen := self lengthOfNameOfClass: classOop.
	nameLen = 0 ifTrue: [self print: 'a ??'. ^nil].
	name := self nameOfClass: classOop.
	nameLen = 10 ifTrue:
		[(self str: name n: 'ByteString' cmp: 10) = 0 "strncmp is weird" ifTrue:
			[self printChar: $"; printStringOf: oop; printChar: $".
			 ^nil].
		 (self str: name n: 'ByteSymbol' cmp: 10) = 0 "strncmp is weird" ifTrue:
			[self printChar: $#; printStringOf: oop.
			 ^nil]].
	(nameLen = 9 and: [(self str: name n: 'Character' cmp: 9) = 0]) ifTrue:
		[self printChar: $$; printChar: (self integerValueOf: (self fetchPointer: 0 ofObject: oop)).
		 ^nil].
	self cCode: [self prin: 'a(n) %.*s' t: nameLen f: name]
		inSmalltalk: [self print: 'a(n) '; print: name]