object format
floatObjectOf: aFloat
	| newFloatObj |
	<inline: false>
	<var: #aFloat type: #double>
	self flag: #Dan.
	newFloatObj := objectMemory eeInstantiateSmallClass: (objectMemory splObj: ClassFloat) sizeInBytes: 8+BaseHeaderSize.
	objectMemory storeFloatAt: newFloatObj + BaseHeaderSize from: aFloat.
	^ newFloatObj.
