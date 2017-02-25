internal interpreter access
setMethod: aMethodObj
	self assert: aMethodObj asUnsignedInteger >= objectMemory startOfMemory.
	super setMethod: aMethodObj