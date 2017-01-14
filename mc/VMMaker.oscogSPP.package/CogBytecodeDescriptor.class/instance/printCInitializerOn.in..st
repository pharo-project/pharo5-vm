translation
printCInitializerOn: aStream in: aCCodeGenerator
	<doNotGenerate>
	| first |
	first := true.
	aStream nextPut: ${; space.
	self class instVarNamesAndTypesForTranslationDo:
		[:ivn :type| | value |
		first ifTrue: [first := false] ifFalse: [aStream nextPut: $,; space].
		value := self instVarNamed: ivn.
		value isVariableBinding
			ifTrue: [aStream nextPutAll: value key]
			ifFalse:
				[(#(#'unsigned char' #'signed char' #('unsigned' ' : 1')) includes: type)
					ifTrue: [value isInteger
								ifTrue: [ivn = 'opcode'
											ifTrue: [aStream nextPutAll: (CogRTLOpcodes nameForOpcode: value)]
											ifFalse: [aStream print: value]]
								ifFalse: [aStream nextPut: ((value notNil and: [value]) ifTrue: [$1] ifFalse: [$0])]]
					ifFalse: [(false and: [#('spanFunction' 'isBackwardBranchFunction') includes: ivn]) ifTrue:
								[aStream nextPut: $(; nextPutAll: type first; nextPutAll: type last; nextPut: $)].
							aStream nextPutAll: (value
													ifNotNil: [aCCodeGenerator cFunctionNameFor: value]
													ifNil: ['0'])]]].
	aStream space; nextPut: $}