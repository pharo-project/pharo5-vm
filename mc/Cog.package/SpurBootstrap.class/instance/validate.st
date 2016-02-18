bootstrap image
validate
	| p n duplicates maxClassIndex savedEndOfMemory |
	self assert: (reverseMap at: newHeap specialObjectsOop) = oldHeap specialObjectsOop.
	self assert: (map at: oldHeap specialObjectsOop) = newHeap specialObjectsOop.
	self assert: (reverseMap at: newHeap classTableRootObj ifAbsent: []) isNil.

	duplicates := { 3. newHeap arrayClassIndexPun. newHeap weakArrayClassIndexPun }.
	maxClassIndex := classToIndex inject: 0 into: [:a :b| a max: b].
	self assert: ((newHeap arrayClassIndexPun to: maxClassIndex) select:
					[:idx| | classObj |
					(classObj := newHeap classOrNilAtIndex: idx) ~= newHeap nilObject
					and: [(newHeap classIndexOf: classObj) = (newHeap rawHashBitsOf: classObj)]]) isEmpty.
	0 to: maxClassIndex do:
		[:index| | classObj |
		(index <= newHeap tagMask
		 and: [index > newHeap isForwardedObjectClassIndexPun]) ifTrue:
			[(classObj := newHeap classOrNilAtIndex: index) = newHeap nilObject
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
	savedEndOfMemory := newHeap endOfMemory.
	newHeap setEndOfMemory: newHeap freeOldSpaceStart.
	newHeap allObjectsDo:
		[:o|
		(o <= newHeap trueObject
		 or: [o > lastClassTablePage]) ifTrue:
			[self assert: (reverseMap includesKey: o).
			 self assert: (newHeap fetchClassOfNonImm: o) = (map at: (oldHeap fetchClassOfNonImm: (reverseMap at: o)))].
		n := n + 1.
		p := o].
	newHeap setEndOfMemory: savedEndOfMemory.
	self touch: p.
	self assert: (n between: map size and: map size + ((imageTypes includes: 'squeak')
														ifTrue: [6]
														ifFalse: [10])). "+ 6 or 10 is room for freelists & classTable"

	"check some class properties to ensure the format changes are correct"
	self assert: (newHeap fixedFieldsOfClassFormat: (newHeap formatOfClass: newHeap classArray)) = 0.
	self assert: (newHeap instSpecOfClassFormat: (newHeap formatOfClass: newHeap classArray)) = newHeap arrayFormat