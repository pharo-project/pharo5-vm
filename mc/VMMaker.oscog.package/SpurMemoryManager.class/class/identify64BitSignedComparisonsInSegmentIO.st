analysis
identify64BitSignedComparisonsInSegmentIO
	"self identify64BitSignedComparisonsInSegmentIO"
	self identifySignedComparisonsFor: #(ObjectMemory Spur64BitMemoryManager)
		in:	(self organization listAtCategoryNamed: #'image segment in/out')
		noise: #(	'classIndex* >= numOutPointers'
					'count > ptr - start / self bytesPerOop'
					'endSeg - segAddr < self baseHeaderSize + self bytesPerOop'
					'errorCode* > 0'
					'GCModeImageSegment > 0'
					'hash - TopHashBit <= outIndex'
					'limit - ptr <= 8'
					'num* >= self numSlotsMask'
					'num* <= 1'
					'num* > 0'
					'num* < 1'
					'outIndex >= (self numSlotsOf: outPointerArray)'
					'outIndex := self mapOopsFrom: * < 0'
					'segAddr - segStart / 8 + self lastClassIndexPun >= TopHashBit'
					'there > 0'
					'* > self identityHashHalfWordMask'
					'*segmentLimit >= self numSlotsMask*'
					'* > self isForwardedObjectClassIndexPun'
					'* > self lastClassIndexPun')