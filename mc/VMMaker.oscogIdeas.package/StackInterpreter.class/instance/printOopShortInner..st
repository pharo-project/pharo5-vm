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
				printHexnp: (objectMemory characterValueOf: oop);
				printChar: $)].
		 (objectMemory isIntegerObject: oop) ifTrue:
			[^self
				printNum: (objectMemory integerValueOf: oop);
				printChar: $(;
				printHexnp: (objectMemory integerValueOf: oop);
				printChar: $)].
		 (objectMemory isImmediateFloat: oop) ifTrue:
			[^self
				printFloat: (objectMemory dbgFloatValueOf: oop);
				printChar: $(;
				printHexnp: oop;
				printChar: $)].
		 ^self print: 'unknown immediate '; printHexnp: oop].
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[^self print: ((oop bitAnd: objectMemory allocationUnit - 1) ~= 0
						ifTrue: [' is misaligned']
						ifFalse: [self whereIs: oop])].
	(objectMemory isFreeObject: oop) ifTrue:
		[^self print: ' is a free chunk'].
	(objectMemory isForwarded: oop) ifTrue:
		[^self print: ' is a forwarder to '; printHexnp: (objectMemory followForwarded: oop)].
	(self isFloatObject: oop) ifTrue:
		[^self printFloat: (objectMemory dbgFloatValueOf: oop)].
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
	((objectMemory isPointersNonImm: oop)
	 and: [(objectMemory instanceSizeOf: classOop) = (ValueIndex + 1)
	 and: [(objectMemory isBytes: (objectMemory fetchPointer: KeyIndex ofObject: oop))]]) ifTrue:
		[| classLookupKey |
		 classLookupKey := objectMemory fetchClassOfNonImm: (objectMemory splObj: SchedulerAssociation).
		 [classLookupKey = objectMemory nilObject ifTrue:
			[^self].
		  (objectMemory instanceSizeOf: classLookupKey) = (KeyIndex + 1)] whileFalse:
			[classLookupKey := self superclassOf: classLookupKey].
		 (self includesBehavior: classOop ThatOf: classLookupKey) ifTrue:
			[self space;
				printOopShort: (objectMemory fetchPointer: KeyIndex ofObject: oop);
				print: ' -> ';
				printHexnp: (objectMemory fetchPointer: ValueIndex ofObject: oop)]]