code generation
fieldAccessorsForBytesPerWord: bytesPerWord
	| fieldSpecs |
	fieldSpecs := OrderedCollection new.
	self instVarNamesAndTypesForTranslationDo:
		[:ivn :typeTuple| | index replacement |
		(index := typeTuple indexOf: #BytesPerWord ifAbsent: 0) > 0
			ifTrue:
				[(typeTuple at: index + 1) = bytesPerWord ifTrue:
					[replacement := typeTuple copyReplaceFrom: index to: index + 1 with: #().
					 replacement size = 1 ifTrue:
						[replacement := replacement first].
					fieldSpecs add: { ivn. replacement }]]
			ifFalse:
				[fieldSpecs add: { ivn. typeTuple }]].
	^fieldSpecs collect:
		[:tuple|
			[:ivn :typeTuple|
			{ ('*unused*' match: ivn) ifTrue: [#unused] ifFalse: [ivn].
			  (typeTuple isArray and: ['unsigned' = typeTuple first])
				ifTrue:
					[Integer readFrom: (typeTuple last readStream skipTo: $:; skipSeparators)]
				ifFalse:
					[typeTuple
						caseOf: {
								[#char]				->	[8].
								[#'unsigned char']	->	[8].
								[#short]			->	[16].
								[#'unsigned short']	->	[16].
								[#int]				->	[32].
								[#'unsigned int']	->	[32] }
						otherwise: [bytesPerWord * 8]].
			typeTuple isArray
				ifTrue:
					[(typeTuple size >= 3 and: [typeTuple second = #Boolean]) ifTrue:
						[#Boolean]]
				ifFalse:
					[typeTuple last = $* ifTrue:
						[(typeTuple beginsWith: 'struct _') "remove struct tag if any"
							ifTrue: [(typeTuple allButFirst: 8) asSymbol]
							ifFalse: [typeTuple]]] }] valueWithArguments: tuple]

	"#(4 8) collect: [:bpw| (CogBlockMethod fieldAccessorsForBytesPerWord: bpw) asArray]"
	"#(4 8) collect: [:bpw| (CogMethod fieldAccessorsForBytesPerWord: bpw) asArray]"