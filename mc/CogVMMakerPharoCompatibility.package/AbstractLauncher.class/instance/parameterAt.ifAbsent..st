private
parameterAt: parName ifAbsent: aBlock
	"Return the parameter named parName.
	Evaluate the block if parameter does not exist."
	^self parameters
		at: parName asUppercase
		ifAbsent: [aBlock value]