free space
isLargeFreeObject: objOop
	^(self bytesInObject: objOop) >= (self numFreeLists * self allocationUnit)