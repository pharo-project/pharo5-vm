allocation
freeSize
	"Return the instantaneous amount of free memory which is that
	 from the allocation pointer freeStart up to the reserve start."
	^(self oop: freeStart isLessThan: reserveStart)
		ifTrue: [(self cCoerce: reserveStart to: #usqInt) - (self cCoerce: freeStart to: #usqInt)]
		ifFalse: [0]