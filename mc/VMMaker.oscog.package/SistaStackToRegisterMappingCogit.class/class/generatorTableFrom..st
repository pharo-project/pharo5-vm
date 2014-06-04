class initialization
generatorTableFrom: anArray
	"Override to replace the unmapped, non-counting inlined #== with a mapped counting inlined #==."
	| table |
	table := super generatorTableFrom: anArray.
	table object do:
		[:descriptor|
		 descriptor generator == #genSpecialSelectorEqualsEquals ifTrue:
			[descriptor
				isMapped: true;
				isMappedInBlock: true;
				needsFrameFunction: nil]].
	^table