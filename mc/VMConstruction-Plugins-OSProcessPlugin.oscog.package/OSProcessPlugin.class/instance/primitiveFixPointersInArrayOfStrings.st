private
primitiveFixPointersInArrayOfStrings
	"This primitive exists only for purposes of testing the
	fixPointersInArrayOfStrings:withOffsets:count: method. I believe it to be
	reasonably machine and compiler independent, but have no way of verifying
	this on a variety of machines, so I'll leave this test method here in case
	someone runs into problems on other hardware or compilers. -dtl"

	<export: true>
	| count offsetArray cStringArray |
	count := interpreterProxy stackIntegerValue: 0.
	offsetArray := interpreterProxy stackObjectValue: 1.
	cStringArray := interpreterProxy stackObjectValue: 2.
	(interpreterProxy failed
	 or: [(self
			fixPointersInArrayOfStrings: cStringArray
			withOffsets: offsetArray) = 0])
		ifTrue: [interpreterProxy primitiveFail]
		ifFalse: [interpreterProxy pop: 4 thenPush: cStringArray]