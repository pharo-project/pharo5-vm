compile abstract instructions
assertExtsAreConsumed: descriptor
	 "extended bytecodes must consume their extensions"
	 <inline: true>
	 descriptor isExtension ifFalse:
		[self assert: (extA = 0 and: [extB = 0])].