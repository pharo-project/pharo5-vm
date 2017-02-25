bytecode generator support
genPushLiteralVariableGivenDirectedSuper: literalIndex
	"This is a version of genPushLiteralVariable: that looks ahead for a directed super send bytecode
	 and does not generate any code for the dereference yet if followed by a directed super send."
	<inline: false>
	self nextDescriptorExtensionsAndNextPCInto:
		[:descriptor :exta :extb :followingPC|
		(self isDirectedSuper: descriptor extA: exta extB: extb) ifTrue:
			[self ssPushConstant: (self getLiteral: literalIndex).
			 ^0]].
	^self genPushLiteralVariable: literalIndex