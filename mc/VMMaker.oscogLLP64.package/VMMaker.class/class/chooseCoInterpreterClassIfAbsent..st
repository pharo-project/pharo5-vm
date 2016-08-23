confs-support
chooseCoInterpreterClassIfAbsent: ifAbsentBlock
	^Smalltalk classNamed:
		 ([:choices|
		   choices
			at: (UIManager default chooseFrom: choices)
			ifAbsent: ifAbsentBlock]
				value: #(CoInterpreter CoInterpreterMT))