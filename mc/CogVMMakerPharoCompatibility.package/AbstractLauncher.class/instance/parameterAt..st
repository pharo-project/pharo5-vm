private
parameterAt: parName
	"Return the parameter named parName or an empty string"
	^self
		parameterAt: parName
		ifAbsent: ['']