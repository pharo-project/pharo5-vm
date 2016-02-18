bytecode generator support
genSendDirectedSuper: selectorIndex numArgs: numArgs
	self assert: self ssTop type = SSConstant.
	tempOop := self ssTop constant.
	self ssPop: 1.
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selectorIndex numArgs: numArgs sendTable: directedSuperSendTrampolines