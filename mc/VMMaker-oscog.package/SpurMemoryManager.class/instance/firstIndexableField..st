object format
firstIndexableField: objOop
	"NOTE: overridden in various simulator subclasses to add coercion to CArray, so please duplicate any changes.
	 There are only two important cases, both for objects with named inst vars, i.e. formats 2,3 & 5.
	 The first indexable field for formats 2 & 5 is the slot count (by convention, even though that's off the end
	 of the object).  For 3 we must go to the class."
	| fmt classFormat |
	<returnTypeC: #'void *'>
	fmt := self formatOf: objOop.
	fmt <= self lastPointerFormat ifTrue: "pointer; may need to delve into the class format word"
		[(fmt between: self indexablePointersFormat and: self weakArrayFormat) ifTrue:
			[classFormat := self formatOfClass: (self fetchClassOfNonImm: objOop).
			 ^self pointerForOop: objOop
								+ self baseHeaderSize
								+ ((self fixedFieldsOfClassFormat: classFormat) << self wordSize)].
		^self pointerForOop: objOop
							+ self baseHeaderSize
							+ ((self numSlotsOf: objOop) << self wordSize)].
	"All bit objects, and indeed CompiledMethod, though this is a non-no, start at 0"
	self assert: fmt < self firstCompiledMethodFormat.
	^self pointerForOop: objOop + self baseHeaderSize