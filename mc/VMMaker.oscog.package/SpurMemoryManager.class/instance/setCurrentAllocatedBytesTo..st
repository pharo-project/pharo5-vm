allocation accounting
setCurrentAllocatedBytesTo: n
	"Reset the allocation count to n (n will typically be zero).  Since we wish to
	 discount the current use we must set statAllocatedBytes to n and update
	 oldSpaceUsePriorToScavenge to discount the current allocated bytes."
	| delta |
	delta := self currentAllocatedBytes - statAllocatedBytes.
	statAllocatedBytes := n.
	oldSpaceUsePriorToScavenge := oldSpaceUsePriorToScavenge + delta.
	self assert: self currentAllocatedBytes = n