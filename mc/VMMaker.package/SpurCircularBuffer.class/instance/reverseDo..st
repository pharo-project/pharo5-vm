enumerating
reverseDo: aBlock
	| ptr |
	last >= start ifTrue:
		[ptr := last.
		 [self assert: (first <= last
						ifTrue: [first <= ptr and: [ptr <= last]]
						ifFalse: [(start <= ptr and: [ptr <= last]) or: [first <= ptr and: [ptr <= limit]]]).
		  aBlock value: (manager longAt: ptr).
		  ptr = first ifTrue: [^nil].
		  (ptr := ptr - manager wordSize) < start ifTrue:
			[ptr := limit]] repeat].
	^nil