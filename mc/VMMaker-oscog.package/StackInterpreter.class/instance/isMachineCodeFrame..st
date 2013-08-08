frame access
isMachineCodeFrame: theFP
	"For compatibility with CoInterpreter.  Needed to avoid slowPrimitiveResponse
	 failing within ceSend:to:numArgs: et al with an unbalanced stack."
	<var: #theFP type: #'char *'>
	<inline: true>
	^false