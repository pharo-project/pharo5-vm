analysis
identify32BitSignedComparisons
	"self identify32BitSignedComparisons"
	self identifySignedComparisonsFor: #(ObjectMemory Spur32BitMemoryManager)
		noise: #('(manager bytesInObject: largestFreeChunk) >= spaceEstimate'
				'(self classIndexOf: o*) > self isForwardedObjectClassIndexPun'
				'GCModeFull > 0'
				'ReceiverIndex + (objectMemory integerValueOf: sp*) < (objectMemory lengthOf: o*)'
				'availableSpace > 0'
				'bytes + 2 * 8 > availableSpace'
				'fmt* < manager firstCompiledMethodFormat'
				'fmt* < self firstCompiledMethodFormat'
				'fmt* <= 5'
				'gcPhaseInProgress > 0'
				'i <= finishIndex'
				'numPointerSlots > 0'
				'scavenger rememberedSetSize > 0')