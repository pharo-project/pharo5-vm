interpreter access
floatObjectOf: aFloat
	| newFloatObj |
	<inline: false>
	<var: #aFloat type: #double>
	<api>
	(self isSmallFloatValue: aFloat) ifTrue:
		[^self smallFloatObjectOf: aFloat].
	newFloatObj := self
						eeInstantiateSmallClassIndex: ClassFloatCompactIndex
						format: self firstLongFormat
						numSlots: (self sizeof: #double) / self bytesPerOop.
	self storeFloatAt: newFloatObj + self baseHeaderSize from: aFloat.
	^newFloatObj