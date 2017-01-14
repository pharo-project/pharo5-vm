accessing
splObj: splObjIndex
	^splObjIndex caseOf: {
		[ClassArray]					-> [self oopForObject: Array].
		[ClassCharacter]				-> [self oopForObject: Character].
		[ClassLargeNegativeInteger]	-> [self oopForObject: LargeNegativeInteger].
		[ClassLargePositiveInteger]	-> [self oopForObject: LargePositiveInteger].
		[ClassSmallInteger]				-> [self oopForObject: SmallInteger].
		[CompactClasses]				-> [self oopForObject: Smalltalk compactClassesArray].
		[LowcodeContextMark]				-> [self oopForObject: (Smalltalk globals at: #LowcodeNativeContext ifPresent: [:cls | cls signalingObject ]) ]
		}