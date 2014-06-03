object format
floatObjectOf: aFloat
	| newFloatObj |
	<var: #aFloat type: #double>
	<inline: false> "because storeFloatAt:from: insists that its last arg is a variable"
	self flag: #Dan. "None of the float stuff has been converted for 64 bits"
	newFloatObj := self instantiateSmallClass: (self splObj: ClassFloat) sizeInBytes: 8+BaseHeaderSize.
	self storeFloatAt: newFloatObj + BaseHeaderSize from: aFloat.
	^newFloatObj