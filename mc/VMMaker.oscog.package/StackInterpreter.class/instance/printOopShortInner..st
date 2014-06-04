debug printing
printOopShortInner: oop
	| classOop name nameLen |
	<var: #name type: #'char *'>
	<inline: true>
	(objectMemory isImmediate: oop) ifTrue:
		[(objectMemory isImmediateCharacter: oop) ifTrue:
			[^self
				printChar: $$;
				printChar: (objectMemory characterValueOf: oop);
				printChar: $(;
				printHex: (objectMemory integerValueOf: oop);
				printChar: $)].
		^self
			printNum: (objectMemory integerValueOf: oop);
			printChar: $(;
			printHex: (objectMemory integerValueOf: oop);
			printChar: $)].
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[^self print: ((oop bitAnd: objectMemory allocationUnit - 1) ~= 0
						ifTrue: [' is misaligned']
						ifFalse: [self whereIs: oop])].
	(objectMemory isOopForwarded: oop) ifTrue:
		[^self printHex: oop; print: ' is a forwarder to '; printHex: (objectMemory followForwarded: oop)].
	(self isFloatObject: oop) ifTrue:
		[^self printFloat: (self dbgFloatValueOf: oop)].
	classOop := objectMemory fetchClassOfNonImm: oop.
	(objectMemory addressCouldBeObj: classOop) ifFalse:
		[^self print: 'a ??'].
	(objectMemory numSlotsOf: classOop) = metaclassNumSlots ifTrue:
		[^self printNameOfClass: oop count: 5].
	oop = objectMemory nilObject ifTrue: [^self print: 'nil'].
	oop = objectMemory trueObject ifTrue: [^self print: 'true'].
	oop = objectMemory falseObject ifTrue: [^self print: 'false'].
	nameLen := self lengthOfNameOfClass: classOop.
	nameLen = 0 ifTrue: [^self print: 'a ??'].
	name := self nameOfClass: classOop.
	nameLen = 10 ifTrue:
		[(self str: name n: 'ByteString' cmp: 10) = 0 "strncmp is weird" ifTrue:
			[^self printChar: $'; printStringOf: oop; printChar: $'].
		 (self str: name n: 'ByteSymbol' cmp: 10) = 0 "strncmp is weird" ifTrue:
			[self printChar: $#; printStringOf: oop. ^self]].
	(nameLen = 9 and: [(self str: name n: 'Character' cmp: 9) = 0]) ifTrue:
		[^self printChar: $$; printChar: (objectMemory integerValueOf: (objectMemory fetchPointer: 0 ofObject: oop))].
	self print: 'a(n) '.
	self
		cCode: [0 to: nameLen - 1 do: [:i| self printChar: (name at: i)]]
		inSmalltalk:
			[name isString
				ifTrue: [self print: name]
				ifFalse: [0 to: nameLen - 1 do: [:i| self printChar: (name at: i)]]].
	"Try to spot association-like things; they're all subclasses of LookupKey"
	((objectMemory instanceSizeOf: classOop) = (ValueIndex + 1)
	 and: [(self superclassOf: classOop) = (self superclassOf: (objectMemory fetchClassOfNonImm: (objectMemory splObj: SchedulerAssociation)))
	 and: [objectMemory isBytes: (objectMemory fetchPointer: KeyIndex ofObject: oop)]]) ifTrue:
		[self space;
			printOopShort: (objectMemory fetchPointer: KeyIndex ofObject: oop);
			print: ' -> ';
			printHex: (objectMemory fetchPointer: ValueIndex ofObject: oop)]