accessing
splObj: splObjIndex
	^splObjIndex caseOf: {
		[ClassArray]		-> [self oopForObject: Array].
		[CompactClasses]	-> [self oopForObject: Smalltalk compactClassesArray]
		}