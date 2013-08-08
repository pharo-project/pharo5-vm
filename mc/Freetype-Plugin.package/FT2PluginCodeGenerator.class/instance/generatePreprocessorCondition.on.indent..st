translating builtins
generatePreprocessorCondition: aNode on: aStream indent: anInteger

	| cond |
	cond := aNode selector caseOf: {
		[#ifDefined:] -> ['#ifdef ', aNode args first value].
		[#ifNotDefined:] -> ['#ifndef ', aNode args first value].
		[#else] -> ['#else'].
		[#endIf] -> ['#endif'].
		[#ifDefined:then:] -> ['#ifdef ', aNode args first value].
		[#ifDefined:then:else:] -> ['#ifdef ', aNode args first value].
		[#ifNotDefined:then:] -> ['#ifndef ', aNode args first value].
		[#ifNotDefined:then:else:] -> ['#ifndef ', aNode args first value].

	} otherwise: [^self error: 'unrecognized preprocessor condition'].
	aStream cr; nextPutAll: cond; cr.
	aNode args size > 1 ifTrue: [
		"if:...do:"
		aNode args second emitCCodeOn: aStream level: anInteger generator: self.
		aNode args size > 2 ifTrue: [
			"if:...do:..else:"
			aStream nextPutAll: '#else'; cr.
			aNode args third emitCCodeOn: aStream level: anInteger generator: self.
		].
		aStream nextPutAll: '#endif'; cr.
	].