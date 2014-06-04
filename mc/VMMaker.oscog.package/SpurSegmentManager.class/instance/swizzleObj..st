snapshot
swizzleObj: objOop
	<inline: false>
	self assert: canSwizzle.
	numSegments - 1 to: 1 by: -1 do:
		[:i|
		objOop >= (segments at: i) segStart ifTrue:
			[^objOop + (segments at: i) swizzle]].
	^objOop + (segments at: 0) swizzle