in-line cacheing
inlineCacheTagForInstance: oop
	"Answer the relevant inline cache tag for an instance.
	 c.f. getInlineCacheClassTagFrom:into: & inlineCacheTagForClass:"
	^(objectMemory isImmediate: oop)
		ifTrue: [oop bitAnd: 1] "SmallInteger => 1, Character => 0"
		ifFalse: [objectMemory classIndexOf: oop]