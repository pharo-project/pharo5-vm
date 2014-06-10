debug support
checkValidInlineCacheTag: classIndexOrTagPattern
	^classIndexOrTagPattern <= objectMemory tagMask
	  or: [(objectMemory classAtIndex: classIndexOrTagPattern) notNil]