*printf
printf
	^ (self indexOf: $%) ~= 0
		ifTrue: [ self ]
		ifFalse: [ (PrintfFormatString new setFormat: self) printf: #() ]