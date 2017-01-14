translation
declareInterpreterVersionIn: aCCodeGenerator defaultName: defaultName
	NewspeakVM ifTrue:
		["Newspeak as of mid 2011 derives SystemScope systemName from the interpreterVersion
		  (via system attribute 1004) by copying up to but not including the last space, provided the
		  string ends with a digit.  So spaces must be eliminated from the Monitcello version string,
		  and we can't surround it with square brackets."
		(aCCodeGenerator shortMonticelloDescriptionForClass: self) last isDigit ifFalse:
			[self error: 'Newspeak expects interpreterVersion ends with a digit'].
		aCCodeGenerator
			var: #interpreterVersion
			declareC: 'const char *interpreterVersion = "Newspeak Virtual Machine ',
							((aCCodeGenerator shortMonticelloDescriptionForClass: self) copyReplaceAll: ' ' with: '_'),
							'"'.
		^self].
	
	aCCodeGenerator
		var: #interpreterVersion
		declareC: 'const char *interpreterVersion = "Croquet Closure ', defaultName, ' VM [',
					(aCCodeGenerator shortMonticelloDescriptionForClass: self),']"'.