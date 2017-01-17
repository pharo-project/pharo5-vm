tests
testPointerTaggingDetagging
	"Test the adding/removal of SmallInteger tags to memory adresses used in
	 StackInterpreter and StackInterpreterSimulator for married context management."

	"StackInterpreterTests new testPointerTaggingDetagging"

	{ StackInterpreterSimulatorLSB new. "StackInterpreterSimulatorMSB new" } do: "Need to add MSB soon"
		[:sis|
		({ sis objectMemory minSmallInteger. sis objectMemory minSmallInteger / 2. -1024. -4. -8.
		    sis objectMemory maxSmallInteger - 1. sis objectMemory maxSmallInteger // 2. 4. 8} collect:
			[:n| n bitClear: sis objectMemory tagMask]) do:
				[:n| | tagged untagged |
				self assert: (n bitAnd: sis objectMemory tagMask) = 0.
				self assert: (sis objectMemory isNonIntegerObject: n).
				tagged := sis withSmallIntegerTags: n.
				untagged := sis withoutSmallIntegerTags: tagged.
				self assert: (sis objectMemory isIntegerObject: tagged).
				self assert: untagged = n]]