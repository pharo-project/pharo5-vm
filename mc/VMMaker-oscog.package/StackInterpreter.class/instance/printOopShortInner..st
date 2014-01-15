debug printing
printOopShortInner: oop
	| classOop name nameLen |
	<var: #name type: #'char *'>
	<inline: true>
	(objectMemory isIntegerObject: oop) ifTrue:
		[self printNum: (objectMemory integerValueOf: oop);
			printChar: $(;
			printHex: (objectMemory integerValueOf: oop);
			printChar: $).
		 ^nil].
	(oop between: objectMemory startOfMemory and: objectMemory freeStart) ifFalse:
		[self printHex: oop; print: ' is not on the heap'.
		 ^nil].
	(oop bitAnd: (BytesPerWord - 1)) ~= 0 ifTrue:
		[self printHex: oop; print: ' is misaligned'.
		 ^nil].
	(self isFloatObject: oop) ifTrue:
		[self printFloat: (self dbgFloatValueOf: oop).
		 ^nil].
	classOop := objectMemory fetchClassOfNonInt: oop.
	(objectMemory addressCouldBeObj: classOop) ifFalse:
		[self print: 'a ??'. ^nil].
	(objectMemory sizeBitsOf: classOop) = metaclassSizeBits ifTrue:
		[self printNameOfClass: oop count: 5.
		 ^nil].
	oop = objectMemory nilObject ifTrue: [self print: 'nil'. ^nil].
	oop = objectMemory trueObject ifTrue: [self print: 'true'. ^nil].
	oop = objectMemory falseObject ifTrue: [self print: 'false'. ^nil].
	nameLen := self lengthOfNameOfClass: classOop.
	nameLen = 0 ifTrue: [self print: 'a ??'. ^nil].
	name := self nameOfClass: classOop.
	nameLen = 10 ifTrue:
		[(self str: name n: 'ByteString' cmp: 10) not "strncmp is weird" ifTrue:
			[self printChar: $'; printStringOf: oop; printChar: $'.
			 ^nil].
		 (self str: name n: 'ByteSymbol' cmp: 10) not "strncmp is weird" ifTrue:
			[self printChar: $#; printStringOf: oop.
			 ^nil]].
	(nameLen = 9 and: [(self str: name n: 'Character' cmp: 9) not]) ifTrue:
		[self printChar: $$; printChar: (objectMemory integerValueOf: (objectMemory fetchPointer: 0 ofObject: oop)).
		 ^nil].
	self cCode: [self prin: 'a(n) %.*s' t: nameLen f: name]
		inSmalltalk: [self print: 'a(n) '; print: name].
	"Try to spot association-like things; they're all subclasses of LookupKey"
	((objectMemory instanceSizeOf: classOop) = (ValueIndex + 1)
	 and: [(self superclassOf: classOop) = (self superclassOf: (objectMemory fetchClassOfNonInt: (objectMemory splObj: SchedulerAssociation)))
	 and: [objectMemory isBytes: (objectMemory fetchPointer: KeyIndex ofObject: oop)]]) ifTrue:
		[self space;
			printOopShort: (objectMemory fetchPointer: KeyIndex ofObject: oop);
			print: ' -> ';
			printHex: (objectMemory fetchPointer: ValueIndex ofObject: oop)]