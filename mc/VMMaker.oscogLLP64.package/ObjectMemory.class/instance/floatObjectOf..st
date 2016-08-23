interpreter access
floatObjectOf: aFloat
	| newFloatObj |
	<inline: false>
	<var: #aFloat type: #double>
	newFloatObj := self instantiateSmallClass: (self splObj: ClassFloat) sizeInBytes: (self sizeof: #double)+self baseHeaderSize.
	self storeFloatAt: newFloatObj + self baseHeaderSize from: aFloat.
	^newFloatObj