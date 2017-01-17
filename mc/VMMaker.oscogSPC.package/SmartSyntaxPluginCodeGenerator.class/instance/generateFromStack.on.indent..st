translating builtins
generateFromStack: aNode on: aStream indent: anInteger
	| idList |
	aNode args first isConstant ifFalse: [^self error: 'arg must be constant'].
	pluginFunctionsUsed add: #stackValue:.
	idList := aNode args first value.
	(1 to: idList size)
		do: [:i | 
			aStream 
				nextPutAll: (idList at: i);
				nextPutAll: ' = stackValue(';
				nextPutAll: (idList size - i) asString;
				nextPut: $)]
		separatedBy: [aStream nextPut: $;; crtab: anInteger].
