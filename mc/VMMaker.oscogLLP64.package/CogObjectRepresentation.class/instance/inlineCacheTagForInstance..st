in-line cacheing
inlineCacheTagForInstance: oop
	"Answer the relevant inline cache tag for an instance.
	 c.f. getInlineCacheClassTagFrom:into: & inlineCacheTagForClass:"
	^self subclassResponsibility