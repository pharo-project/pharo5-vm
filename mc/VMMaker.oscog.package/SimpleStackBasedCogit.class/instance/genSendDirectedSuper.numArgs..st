bytecode generator support
genSendDirectedSuper: selector numArgs: numArgs
	<inline: false>
	"N.B. genPushLiteralVariableGivenDirectedSuper: has already loaded tempOop with the association."
	^self genSend: selector numArgs: numArgs sendTable: directedSuperSendTrampolines