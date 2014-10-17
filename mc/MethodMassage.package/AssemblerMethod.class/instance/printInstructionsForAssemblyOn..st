printing
printInstructionsForAssemblyOn: aStream
	instructions do:
		[:messageOrLabel|
		aStream crtab.
		(self isLabel: messageOrLabel)
			ifTrue:
				[aStream nextPutAll: 'label: '; print: messageOrLabel key]
			ifFalse:
				[messageOrLabel numArgs = 0
					ifTrue: [aStream nextPutAll: messageOrLabel selector]
					ifFalse:
						[messageOrLabel selector keywords with: messageOrLabel arguments do:
							[:kwd :arg|
							aStream nextPutAll: kwd; space.
							aStream print: ((kwd = 'jump:' or: [kwd = 'blockSize:'])
												ifTrue: [self assert: (self isLabel: arg).
														arg key]
												ifFalse: [arg]); space].
						aStream skip: -1]].
		aStream nextPut: $;]