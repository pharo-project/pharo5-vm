snapshot
defaultEdenBytes
	"Answer the default amount of memory to allocate for the eden space.
	 The actual value can be set via vmParameterAt: and/or a preference in the ini file.
	 The shootout tests seem to plateau at 5 or 6Mb.

	 Originally, both the 32-bit and 64-bit versions used the same 4Mb default.  Measuring
	 the simulator on image start-up, the 64-bit system's eden at the same point in start-up
	 (the first copyBits) is only 8% larger in bytes because it allocates 26% fewer objects.
	 Some 21% of the objects in the 32-bit version's eden are large integers and floats that
	 are representable as 64-bit immediates.

	 But when running benchmarks such as the computer language shootout's binary trees,
	 using the same amount of memory for the 64-bit system causes a significant slow-down
	 and a lot of compactions.  So we now use 4Mb for 32-bits and 7Mb for 64-bits."
	<inline: false>
	^7 * 1024 * 1024

	"Here are the expressions used to collect the above-mentioned figures:"
	"freeStart - self newSpaceStart"
	"| n | n := 0. self allNewSpaceObjectsDo: [:o| n := n + 1]. n"
	"| f | f := 0. self allNewSpaceObjectsDo: [:o| (self isFloatObject: o) ifTrue: [f := f + 1]]. f"
	"| l | l := 0. self allNewSpaceObjectsDo: [:o|
		(((self classIndexOf: o)
			between: ClassLargeNegativeIntegerCompactIndex
			and: ClassLargePositiveIntegerCompactIndex)
		 and: [(self numBytesOfBytes: o) <= 8
		 and: [self isIntegerValue: (coInterpreter signed64BitValueOf: o)]]) ifTrue: [l := l + 1]]. l"