utilities
makePointwithxValue: xValue yValue: yValue
"make a Point xValue@yValue.
We know both will be integers so no value nor root checking is needed"
	| pointResult |
	pointResult := self instantiateSmallClass: (self splObj: ClassPoint) sizeInBytes: 3*self wordSize.
	self storePointerUnchecked: XIndex ofObject: pointResult withValue: (self integerObjectOf: xValue).
	self storePointerUnchecked: YIndex ofObject: pointResult withValue: (self integerObjectOf: yValue).
	^ pointResult