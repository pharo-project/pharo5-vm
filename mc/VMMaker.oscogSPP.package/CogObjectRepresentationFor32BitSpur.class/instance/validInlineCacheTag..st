debug support
validInlineCacheTag: classIndexOrTagPattern
	"The two valid tag patterns are 0 (Character) and 1 (SmallInteger)"
	<var: 'classIndexOrTagPattern' type: #usqInt>
	^classIndexOrTagPattern <= 1
	  or: [(objectMemory classAtIndex: classIndexOrTagPattern) notNil]