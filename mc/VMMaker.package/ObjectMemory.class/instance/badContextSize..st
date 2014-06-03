contexts
badContextSize: oop
	^(self byteLengthOf: oop) ~= (SmallContextSize-BaseHeaderSize)
	   and: [(self byteLengthOf: oop) ~= (LargeContextSize-BaseHeaderSize)]