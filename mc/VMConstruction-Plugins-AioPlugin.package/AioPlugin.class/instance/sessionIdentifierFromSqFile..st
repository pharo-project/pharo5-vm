private - SQFile access
sessionIdentifierFromSqFile: sqFile
	"Answer the session identifier from a SQFile structure. For a valid file
	reference, this identifier will match the session identifier supplied by
	the interpreter."

	<inline: true>
	<returnTypeC: 'SESSIONIDENTIFIERTYPE'>
	<var: 'sqFile' type: 'SQFile *'>
	^ self cCode: 'sqFile->sessionID' inSmalltalk: [-1]
