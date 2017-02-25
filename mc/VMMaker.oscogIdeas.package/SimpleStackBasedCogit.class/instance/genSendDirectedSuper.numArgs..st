bytecode generator support
genSendDirectedSuper: selectorIndex numArgs: numArgs
	<inline: false>
	"N.B. genPushLiteralVariableGivenDirectedSuper: has already loaded tempOop with the association."
	^self genSend: selectorIndex numArgs: numArgs sendTable: directedSuperSendTrampolines