young referers
roomOnYoungReferrersList
	"The youngReferrers list holds methods that may contain a reference to a young
	 object and hence need to be visited during young-space garbage collection.  The
	 list saves walking through all of code space to do so, as in typical circumstances
	 there are no methods that refer to young objects.However, events like become:
	 can potentially cause every method to refer to a new object (becomming true for
	 example).  So there needs to be room on the list for as many methods as exist."
	self assert: (youngReferrers <= limitAddress
				and: [youngReferrers >= (limitAddress - (methodCount * BytesPerWord))]).
	^limitAddress - (methodCount * BytesPerWord) >= mzFreeStart