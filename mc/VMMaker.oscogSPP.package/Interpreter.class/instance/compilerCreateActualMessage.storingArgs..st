compiler support
compilerCreateActualMessage: aMessage storingArgs: argArray
	^self cCode: 'compilerHooks[14](aMessage, argArray)'