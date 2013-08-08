printing
printRegisterState: registerStateVector on: aStream
	| rsvs fields|
	aStream ensureCr.
	rsvs := registerStateVector readStream.
	fields := #(	r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 sp lr pc eflags cr).
	fields withIndexDo:
		[:sym :index| | val |
		sym = #cr
			ifTrue: [aStream cr]
			ifFalse:
				[(val := rsvs next) isNil ifTrue: [^self].
				aStream nextPutAll: sym; nextPut: $:; space.
				val printOn: aStream base: 16 length: 8 padded: true.
				#eflags == sym
					ifTrue:
						[aStream space.
						 "'FIVCZN'"'--VCZN' withIndexDo:
							[:flag :bitIndex|
							flag ~= $- ifTrue:
								[aStream nextPut: flag; nextPutAll: 'F='; print: (val bitAnd: 1 << (bitIndex - 1)) >> (bitIndex - 1); space]]]
					ifFalse:
						[val > 16 ifTrue:
							[aStream space; nextPut: $(.
							 val printOn: aStream base: 10 length: 1 padded: false.
							 aStream nextPut: $)]].
				(fields at: index + 1) ~~ #cr ifTrue:
					[aStream tab]]]