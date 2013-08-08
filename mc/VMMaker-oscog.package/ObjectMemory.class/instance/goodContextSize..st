contexts
goodContextSize: oop
	^(self byteLengthOf: oop) = (SmallContextSize-BaseHeaderSize)
	   or: [(self byteLengthOf: oop) = (LargeContextSize-BaseHeaderSize)]