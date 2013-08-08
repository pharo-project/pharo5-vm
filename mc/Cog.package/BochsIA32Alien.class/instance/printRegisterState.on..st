printing
printRegisterState: registerStateVector on: aStream
	| rsvs fields|
	aStream ensureCr.
	rsvs := registerStateVector readStream.
	fields := (registerStateVector size < 18
			   or: [(11 to: 18) allSatisfy: [:i| (registerStateVector at: i) isZero]])
				ifTrue:
					[#(	eax ebx ecx edx cr
						esp ebp esi edi cr
						eip eflags cr )]
				ifFalse:
					[#(	eax ebx ecx edx cr
						esp ebp esi edi cr
						eip eflags cr
						xmm0low xmm1low cr
						xmm2low xmm3low cr
						xmm4low xmm5low cr
						xmm6low xmm7low cr )].
	fields withIndexDo:
		[:sym :index| | val |
		sym = #cr
			ifTrue: [aStream cr]
			ifFalse:
				[(val := rsvs next) isNil ifTrue: [^self].
				(sym beginsWith: 'xmm')
					ifTrue:
						[aStream nextPutAll: sym; nextPut: $:; space.
						 val printOn: aStream base: 16 length: 16 padded: true.
						 aStream space; nextPut: $(.
						 "At the image level Float is apparently in big-endian format"
						 ((Float basicNew: 2)
						 	at: 2 put: (val bitAnd: 16rFFFFFFFF);
							at: 1 put: (val bitShift: -32);
							yourself)
								printOn: aStream.
						 aStream nextPut: $)]
					ifFalse:
						[aStream nextPutAll: sym; nextPut: $:; space.
						 val printOn: aStream base: 16 length: 8 padded: true.
						 #eflags == sym
							ifTrue:
								[aStream space.
								 'C-P-A-ZS---O' withIndexDo:
									[:flag :bitIndex|
									flag ~= $- ifTrue:
										[aStream nextPut: flag; nextPutAll: 'F='; print: (val bitAnd: 1 << (bitIndex - 1)) >> (bitIndex - 1); space]]]
							ifFalse:
								[val > 16 ifTrue:
									[aStream space; nextPut: $(.
									 val printOn: aStream base: 10 length: 1 padded: false.
									 aStream nextPut: $)]]].
						(fields at: index + 1) ~~ #cr ifTrue:
							[aStream tab]]]