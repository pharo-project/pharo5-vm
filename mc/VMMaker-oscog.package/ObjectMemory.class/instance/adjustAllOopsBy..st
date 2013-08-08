initialization
adjustAllOopsBy: bytesToShift 
	"Adjust all oop references by the given number of bytes. This 
	is done just after reading in an image when the new base 
	address of the object heap is different from the base address 
	in the image."
	"di 11/18/2000 - return number of objects found"

	| oop totalObjects |
	<inline: false>
	bytesToShift = 0 ifTrue: [^300000].
	"this is probably an improvement over the previous answer of 
	nil, but maybe we should do the obejct counting loop and 
	simply guard the adjustFieldsAndClass... with a bytesToShift 
	= 0 ifFalse: ?"
	totalObjects := 0.
	oop := self firstObject.
	[self oop: oop isLessThan: endOfMemory]
		whileTrue:
			[(self isFreeObject: oop)
				ifFalse:
					[totalObjects := totalObjects + 1.
					 self adjustFieldsAndClassOf: oop by: bytesToShift].
			 oop := self objectAfter: oop].
	^totalObjects