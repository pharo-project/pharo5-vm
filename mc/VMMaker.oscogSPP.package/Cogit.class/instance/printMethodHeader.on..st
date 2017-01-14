disassembly
printMethodHeader: cogMethod on: aStream
	<doNotGenerate>
	self cCode: ''
		inSmalltalk:
			[cogMethod isInteger ifTrue:
				[^self printMethodHeader: (self cogMethodOrBlockSurrogateAt: cogMethod) on: aStream]].
	aStream ensureCr.
	cogMethod asInteger printOn: aStream base: 16.
	cogMethod cmType = CMMethod ifTrue:
		[aStream crtab; nextPutAll: 'objhdr: '.
		cogMethod objectHeader printOn: aStream base: 16].
	cogMethod cmType = CMBlock ifTrue:
		[aStream crtab; nextPutAll: 'homemth: '.
		cogMethod cmHomeMethod asUnsignedInteger printOn: aStream base: 16.
		aStream
			nextPutAll: ' (offset '; print: cogMethod homeOffset; nextPut: $);
			crtab; nextPutAll: 'startpc: '; print: cogMethod startpc].
	aStream
		crtab; nextPutAll: 'nArgs: ';	print: cogMethod cmNumArgs;
		tab;    nextPutAll: 'type: ';	print: cogMethod cmType.
	(cogMethod cmType ~= 0 and: [cogMethod cmType ~= CMBlock]) ifTrue:
		[aStream crtab; nextPutAll: 'blksiz: '.
		cogMethod blockSize printOn: aStream base: 16.
		cogMethod cmType = CMMethod ifTrue:
			[aStream crtab; nextPutAll: 'method: '.
			 cogMethod methodObject printOn: aStream base: 16.
			 aStream crtab; nextPutAll: 'mthhdr: '.
			 cogMethod methodHeader printOn: aStream base: 16].
		aStream crtab; nextPutAll: 'selctr: '.
		cogMethod selector printOn: aStream base: 16.
		(coInterpreter lookupAddress: cogMethod selector) ifNotNil:
			[:string| aStream nextPut: $=; nextPutAll: string].
		cogMethod cmType = CMMethod ifTrue:
			[aStream crtab; nextPutAll: 'blkentry: '.
			 cogMethod blockEntryOffset printOn: aStream base: 16.
			 cogMethod blockEntryOffset ~= 0 ifTrue:
				[aStream nextPutAll: ' => '.
				 cogMethod asInteger + cogMethod blockEntryOffset printOn: aStream base: 16]]].
	cogMethod cmType = CMClosedPIC
		ifTrue:
			[aStream crtab; nextPutAll: 'cPICNumCases: '.
			 cogMethod cPICNumCases printOn: aStream base: 16.
			 aStream tab; nextPutAll: 'cpicHasMNUCase: ';
			 nextPutAll: (cogMethod cpicHasMNUCase ifTrue: ['yes'] ifFalse: ['no'])]
		ifFalse:
			[aStream crtab; nextPutAll: 'stackCheckOffset: '.
			 cogMethod stackCheckOffset printOn: aStream base: 16.
			 cogMethod stackCheckOffset > 0 ifTrue:
				[aStream nextPut: $/.
				 cogMethod asInteger + cogMethod stackCheckOffset printOn: aStream base: 16].
			cogMethod cmType = CMBlock
				ifTrue:
					[aStream
						crtab;
						nextPutAll: 'cbUsesInstVars ';
						nextPutAll: (cogMethod cbUsesInstVars ifTrue: ['yes'] ifFalse: ['no'])]
				ifFalse:
					[aStream
						crtab;
						nextPutAll: 'cmRefersToYoung: ';
						nextPutAll: (cogMethod cmRefersToYoung ifTrue: ['yes'] ifFalse: ['no']);
						tab;
						nextPutAll: 'cmIsFullBlock: ';
						nextPutAll: (cogMethod cmIsFullBlock ifTrue: ['yes'] ifFalse: ['no'])].
			cogMethod cmType = CMMethod ifTrue:
				[([cogMethod nextMethodOrIRCs] on: MessageNotUnderstood do: [:ex| nil]) ifNotNil:
					[:nmoircs| aStream crtab; nextPutAll: 'nextMethodOrIRCs: '.
						nmoircs = 0 ifTrue: [aStream print: nmoircs] ifFalse: [coInterpreter printHex: nmoircs]].
				 ([cogMethod counters] on: MessageNotUnderstood do: [:ex| nil]) ifNotNil:
					[:cntrs| aStream crtab; nextPutAll: 'counters: '.
						cntrs = 0 ifTrue: [aStream print: cntrs] ifFalse: [coInterpreter printHex: cntrs]]]].
	aStream cr; flush