assembly
methodReturnConstant: aLiteral
	"Rubbish way of handling special constants."
	^[encoder sizeReturnSpecialLiteral: aLiteral]
		on: Error
		do: [:ex| ex return: (self pushLiteral: aLiteral) + self methodReturnTop]