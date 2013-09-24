initialization
adjustAllOopsBy: bytesToShift 
	"Adjust all oop references by the given number of bytes. This 
	is done just after reading in an image when the new base 
	address of the object heap is different from the base address 
	in the image."

	| obj |
	<inline: false>
	bytesToShift ~= 0 ifTrue:
		[self assert: self newSpaceIsEmpty.
		 obj := self firstObject.
		 [self oop: obj isLessThan: freeOldSpaceStart] whileTrue:
			[(self isFreeObject: obj) ifFalse:
				[self adjustFieldsAndClassOf: obj by: bytesToShift].
			 obj := self objectAfter: obj]]