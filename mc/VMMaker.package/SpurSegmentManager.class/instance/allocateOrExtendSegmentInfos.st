private
allocateOrExtendSegmentInfos
	"Increase the number of allocated segInfos by 16."
	| newNumSegs |
	numSegInfos = 0 ifTrue:
		[numSegInfos := 16.
		 segments := self
						cCode: [self c: numSegInfos alloc: (self sizeof: SpurSegmentInfo)]
						inSmalltalk: [CArrayAccessor on: ((1 to: numSegInfos) collect: [:i| SpurSegmentInfo new])].
		 ^self].
	newNumSegs := numSegInfos + 16.
	segments := self
						cCode: [self re: segments alloc: newNumSegs * (self sizeof: SpurSegmentInfo)]
						inSmalltalk: [CArrayAccessor on: segments object,
									((numSegInfos to: newNumSegs) collect: [:i| SpurSegmentInfo new])].
	self cCode:
		[segments = 0 ifTrue:
			[self error: 'out of memory; cannot allocate more segments'].
		 self
			me: segments + numSegInfos
			ms: 0
			et: newNumSegs - numSegInfos * (self sizeof: SpurSegmentInfo)].
	numSegInfos := newNumSegs