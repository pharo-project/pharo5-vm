assembly
methodReturnConstant: aLiteral
	"Rubbish way of handling special constants."
	^[encoder genReturnSpecialLiteral: aLiteral]
		on: Error
		do: [:ex| ex return: (self pushLiteral: aLiteral) + self methodReturnTop]