interpreter access
floatObjectOf: aFloat
	| newFloatObj |
	<inline: false>
	<var: #aFloat type: #double>
	<api>
	newFloatObj := self
						eeInstantiateSmallClassIndex: ClassFloatCompactIndex
						format: self firstLongFormat
						numSlots: (self sizeof: #double) / self bytesPerOop.
	self storeFloatAt: newFloatObj + self baseHeaderSize from: aFloat.
	^newFloatObj