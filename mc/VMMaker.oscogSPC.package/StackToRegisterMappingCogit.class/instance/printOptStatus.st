simulation only
printOptStatus
	<doNotGenerate>
	coInterpreter transcript ensureCr; nextPutAll: 'opt: '.
	(optStatus isReceiverResultRegLive ~~ true
	 and: [optStatus ssEntry isNil]) ifTrue:
		[coInterpreter transcript nextPutAll: 'none'].
	optStatus printStateOn: coInterpreter transcript.
	coInterpreter transcript cr; flush