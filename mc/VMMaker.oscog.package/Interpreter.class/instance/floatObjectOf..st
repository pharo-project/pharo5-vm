object format
floatObjectOf: aFloat
	| newFloatObj |
	<inline: false>
	<var: #aFloat type: 'double '>
	self flag: #Dan.
	newFloatObj := self instantiateSmallClass: (self splObj: ClassFloat) sizeInBytes: 8+self baseHeaderSize.
	self storeFloatAt: newFloatObj + self baseHeaderSize from: aFloat.
	^ newFloatObj.
