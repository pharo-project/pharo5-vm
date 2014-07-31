contexts
badContextSize: oop
	^(self numBytesOf: oop) ~= (SmallContextSize-BaseHeaderSize)
	   and: [(self numBytesOf: oop) ~= (LargeContextSize-BaseHeaderSize)]