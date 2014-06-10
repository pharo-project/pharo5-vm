object format
floatObjectOf: aFloat
	| newFloatObj |
	<inline: false>
	<var: #aFloat type: #double>
	newFloatObj := objectMemory
						eeInstantiateSmallClassIndex: ClassFloatCompactIndex
						format: objectMemory firstLongFormat
						numSlots: 8 / objectMemory wordSize.
	objectMemory storeFloatAt: newFloatObj + objectMemory baseHeaderSize from: aFloat.
	^newFloatObj