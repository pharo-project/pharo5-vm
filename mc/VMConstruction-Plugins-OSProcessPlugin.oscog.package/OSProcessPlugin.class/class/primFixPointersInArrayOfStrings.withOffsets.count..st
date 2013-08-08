private - testing
primFixPointersInArrayOfStrings: cStringArray withOffsets: offsetArray count: count
	"This primitive call exists only for purposes of testing the
	fixPointersInArrayOfStrings:withOffsets:count: method. I believe it to be
	reasonably machine and compiler independent, but have no way of verifying
	this on a variety of machines, so I'll leave this test method here in case
	someone runs into problems on other hardware or compilers. -dtl"

	"| a |
	a := OSProcess thisOSProcess envAsFlatArrayAndOffsets: UnixProcess env.
	OSProcessPlugin primFixPointersInArrayOfStrings: (a at: 1)
		withOffsets: (a at: 2)
		count: (a at: 2) size"

	<primitive: 'primitiveFixPointersInArrayOfStrings' module: 'UnixOSProcessPlugin'>
	^ nil