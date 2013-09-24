simulation
lookupAddress: address
	"If address appears to be that of a Symbol or a few well-known objects (such as classes) answer it, otherwise answer nil.
	 For code disassembly"
	<doNotGenerate>
	| fmt size string class classSize maybeThisClass classNameIndex thisClassIndex |
	(self addressCouldBeObj: address) ifFalse:
		[^nil].
	fmt := self formatOf: address.
	size := self lengthOf: address baseHeader: (self baseHeader: address) format: fmt.
	size = 0 ifTrue:
		[^address caseOf: { [nilObj] -> ['nil']. [trueObj] -> ['true']. [falseObj] -> ['false'] } otherwise: []].
	((fmt between: 8 and: 11) "indexable byte fields"
	and: [(size between: 1 and: 64)
	and: [Scanner isLiteralSymbol: (string := (0 to: size - 1) collect: [:i| Character value: (self fetchByte: i ofObject: address)])]]) ifTrue:
		[^'#', (ByteString withAll: string)].
	class := self fetchClassOfNonImm: address.
	((self addressCouldBeObj: class)
	 and: [(self headerType: class) ~= HeaderTypeShort]) ifFalse:
		[^nil].
	"address is either a class or a metaclass, or an instance of a class or invalid.  determine which."
	classNameIndex := coInterpreter classNameIndex.
	thisClassIndex := coInterpreter thisClassIndex.
	((classSize := self lengthOf: class baseHeader: (self baseHeader: address) format: fmt) <= (classNameIndex max: thisClassIndex)
	 or: [classSize > 255]) ifTrue:
		[^nil].
	"Address could be a class or a metaclass"
	(fmt = 1 and: [size >= classNameIndex]) ifTrue:
		["Is address a class? If so class's thisClass is address."
		 (self lookupAddress: (self fetchPointer: classNameIndex ofObject: address)) ifNotNil:
			[:maybeClassName|
			(self fetchPointer: thisClassIndex ofObject: class) = address ifTrue:
				[^maybeClassName allButFirst]].
		"Is address a Metaclass?  If so class's name is Metaclass and address's thisClass holds the class name"
		((self isBytes: (self fetchPointer: classNameIndex ofObject: class))
		 and: [(self lookupAddress: (self fetchPointer: classNameIndex ofObject: class)) = '#Metaclass'
		 and: [size >= thisClassIndex]]) ifTrue:
			[maybeThisClass := self fetchPointer: thisClassIndex ofObject: address.
			(self lookupAddress: (self fetchPointer: classNameIndex ofObject: maybeThisClass)) ifNotNil:
				[:maybeThisClassName| ^maybeThisClassName allButFirst, ' class']]].
	^(self lookupAddress: (self fetchPointer: classNameIndex ofObject: class)) ifNotNil:
		[:maybeClassName| 'a(n) ', maybeClassName allButFirst]