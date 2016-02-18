enilopmarts
callRegisterArgCogMethod: cogMethod at: entryOffset receiver: rcvr
	"convert
	 		rcvr	base
			arg(s)
			retpc	<- sp
	 to
			retpc	base
			entrypc
			rcvr
			arg(s)	<- sp
	 and then enter at either the checked or the unchecked entry-point."
	<option: #StackToRegisterMappingCogit>
	<var: #cogMethod type: #'CogMethod *'>
	self assert: (cogit numRegArgs > 0 and: [cogit numRegArgs <= 2 and: [cogMethod cmNumArgs <= cogit numRegArgs]]).
	cogMethod cmNumArgs = 2 ifTrue:
		[self stackValue: 3 put: self stackTop. "retpc"
		 self push: (self stackValue: 1). "last arg"
		 self stackValue: 1 put: (self stackValue: 3). "first arg"
		 self stackValue: 2 put: rcvr.
		 self stackValue: 3 put: cogMethod asInteger + entryOffset.
		 cogit ceCallCogCodePopReceiverArg1Arg0Regs
		"NOTREACHED"].
	cogMethod cmNumArgs = 1 ifTrue:
		[self stackValue: 2 put: self stackTop. "retpc"
		 self push: (self stackValue: 1). "arg"
		 self stackValue: 1 put: rcvr.
		 self stackValue: 2 put: cogMethod asInteger + entryOffset.
		 cogit ceCallCogCodePopReceiverArg0Regs
		"NOTREACHED"].
	self assert: cogMethod cmNumArgs = 0.
	self stackValue: 1 put: self stackTop. "retpc"
	self stackValue: 0 put: cogMethod asInteger + entryOffset.
	self push: rcvr.
	cogit ceCallCogCodePopReceiverReg
	"NOTREACHED"