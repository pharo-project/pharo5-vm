private - SQFile access
sessionIdentifierFromSqFile: sqFile
	"Answer the session identifier from a SQFile structure. For a valid file reference,
	 this identifier will match the session identifier supplied by the interpreter."
	"Define as a macro to eliminate warnings about unrenameable C."
	<cmacro: '(sqFile) (((SQFile *)(sqFile))->sessionID)'>
	^-1

"Old code:
	<inline: true>
	<returnTypeC: 'SESSIONIDENTIFIERTYPE'>
	<var: 'sqFile' type: 'SQFile *'>
	^ self cCode: 'sqFile->sessionID' inSmalltalk: [-1]"
