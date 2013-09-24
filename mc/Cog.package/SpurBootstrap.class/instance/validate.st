bootstrap image
validate
	| p n duplicates maxClassIndex |
	self assert: (reverseMap at: newHeap specialObjectsOop) = oldHeap specialObjectsOop.
	self assert: (map at: oldHeap specialObjectsOop) = newHeap specialObjectsOop.
	self assert: (reverseMap at: newHeap classTableRootObj ifAbsent: []) isNil.

	duplicates := { 3. newHeap arrayClassIndexPun. newHeap weakArrayClassIndexPun }.
	maxClassIndex := classToIndex inject: 0 into: [:a :b| a max: b].
	self assert: ((newHeap arrayClassIndexPun to: maxClassIndex) select:
					[:idx| | classObj |
					(classObj := newHeap classAtIndex: idx) ~= newHeap nilObject
					and: [(newHeap classIndexOf: classObj) = (newHeap rawHashBitsOf: classObj)]]) isEmpty.
	0 to: maxClassIndex do:
		[:index| | classObj |
		(index <= newHeap tagMask
		 and: [index > newHeap isForwardedObjectClassIndexPun]) ifTrue:
			[(classObj := newHeap classAtIndex: index) = newHeap nilObject
				ifTrue:
					[self assert: (classToIndex keyAtValue: index ifAbsent: []) isNil]
				ifFalse:
					[self assert: (newHeap classIndexOf: classObj) ~= (newHeap rawHashBitsOf: classObj).
					(duplicates includes: index) ifFalse:
						[self assert: (newHeap rawHashBitsOf: classObj) = index]]]].
	classToIndex keysAndValuesDo:
		[:oldClass :idx|
		self assert: (newHeap rawHashBitsOf: (map at: oldClass)) = idx. 
		self assert: oldClass = (reverseMap at: (newHeap classAtIndex: idx))].
	n := 0.
	newHeap allObjectsDo:
		[:o|
		(o <= newHeap trueObject
		 or: [o > lastClassTablePage]) ifTrue:
			[self assert: (reverseMap includesKey: o).
			 self assert: (newHeap fetchClassOfNonImm: o) = (map at: (oldHeap fetchClassOfNonImm: (reverseMap at: o)))].
		n := n + 1.
		p := o].
	p class.
	self assert: (n between: map size and: map size + 5). "+ 5 is room for classTable"

	"check some class properties to ensure the format changes are correct"
	self assert: (newHeap fixedFieldsOfClassFormat: (newHeap formatOfClass: newHeap classArray)) = 0.
	self assert: (newHeap instSpecOfClassFormat: (newHeap formatOfClass: newHeap classArray)) = newHeap arrayFormat