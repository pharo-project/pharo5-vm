object format
floatObjectOf: aFloat
	| newFloatObj |
	<inline: false>
	<var: #aFloat type: #double>
	newFloatObj := objectMemory
						eeInstantiateSmallClassIndex: ClassFloatCompactIndex
						format: objectMemory firstLongFormat
						numSlots: (self sizeof: #double) / objectMemory bytesPerOop.
	objectMemory storeFloatAt: newFloatObj + objectMemory baseHeaderSize from: aFloat.
	^newFloatObj