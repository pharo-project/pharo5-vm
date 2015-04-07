bytecode generator support
genSendDirectedSuper: selector numArgs: numArgs
	self assert: self ssTop type = SSConstant.
	tempOop := self ssTop constant.
	self ssPop: 1.
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selector numArgs: numArgs sendTable: directedSuperSendTrampolines