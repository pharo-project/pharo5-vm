assembly-public
assemble: ass "<AssemblerMethod>"
	code := ass.
	sizes := Array new: code instructions size.
	self createEncoder.
	self nilLabelTargets.
	self sizePasses.
	self createMethod.
	self emitPass.
	^method