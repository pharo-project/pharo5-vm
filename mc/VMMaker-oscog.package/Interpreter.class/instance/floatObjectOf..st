object format
floatObjectOf: aFloat
	| newFloatObj |
	<inline: false>
	<var: #aFloat type: 'double '>
	self flag: #Dan.
	newFloatObj := self instantiateSmallClass: (self splObj: ClassFloat) sizeInBytes: 8+BaseHeaderSize.
	self storeFloatAt: newFloatObj + BaseHeaderSize from: aFloat.
	^ newFloatObj.
