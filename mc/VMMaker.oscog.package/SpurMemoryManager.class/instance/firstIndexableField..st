object format
firstIndexableField: objOop
	"NOTE: overridden in various simulator subclasses to add coercion to CArray, so please duplicate any changes.
	 There are only two important cases, both for objects with named inst vars, i.e. formats 2,3 & 5.
	 The first indexable field for formats 2 & 5 is the slot count (by convention, even though that's off the end
	 of the object).  For 3 we must go to the class."
	| fmt classFormat |
	<returnTypeC: #'void *'>
	fmt := self formatOf: objOop.
	fmt <= self weakArrayFormat ifTrue:
		[fmt = self arrayFormat ifTrue: "array starts at 0."
			[^self pointerForOop: objOop + self baseHeaderSize].
		 fmt >= self indexablePointersFormat ifTrue: "indexable with inst vars; need to delve into the class format word"
			[classFormat := self formatOfClass: (self fetchClassOfNonImm: objOop).
			 ^self pointerForOop: objOop
								+ self baseHeaderSize
								+ ((self fixedFieldsOfClassFormat: classFormat) << self shiftForWord)].
		 "otherwise not indexable"
		 ^0].
	"All bit objects, and indeed CompiledMethod, though this is a no-no, start at 0"
	(fmt >= self sixtyFourBitIndexableFormat
	 and: [fmt < self firstCompiledMethodFormat]) ifTrue:
		[^self pointerForOop: objOop + self baseHeaderSize].
	"otherwise not indexable"
	^0