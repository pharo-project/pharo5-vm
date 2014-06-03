initialization
initializeWithOptions: optionsDictionary
	"NewObjectMemory initializeWithOptions: Dictionary new"

	super initializeWithOptions: optionsDictionary.

	"The AllocationCheckFiller is used to fill newSpace and hence check for
	 writes beyond the ends of objects which would overwrite the filler."
	(optionsDictionary includesKey: #AllocationCheckFiller)
		ifTrue:
			[AllocationCheckFiller := optionsDictionary at: #AllocationCheckFiller]
		ifFalse:
			[AllocationCheckFiller isNil ifTrue:
				[AllocationCheckFiller := #(	0				"no allocation check"
											16r55AA55AA	"fill with 16r55AA55AA"
											16rADD4E55)	"fill with address"
												last
				"AllocationCheckFiller := 0"
				"AllocationCheckFiller := 16r55AA55AA"
				"AllocationCheckFiller := 16rADD4E55"]]