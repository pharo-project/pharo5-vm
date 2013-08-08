deprecated
primitiveGetStdErrHandleWithSessionIdentifier
	"Answer the file handle for standard error of my OS process. The session
	identifier is passed as the parameter to this primitive. Use this variant if
	the session identifier is not available directly in the VM (as may be the
	case if it is not possible to link from this plugin to a variable elsewhere
	in the VM)."

	| file thisSession fileOop |
	<export: true>
	<var: 'file' declareC: 'SQFile *file'>
	<var: 'thisSession' type: 'SESSIONIDENTIFIERTYPE'>
	fileOop := self newSQFileByteArray.
	file := self fileValueOf: fileOop.
	thisSession := self sessionIdentifierFrom: (interpreterProxy stackObjectValue: 0).
	self cCode: 'file->file = stderr'.
	self cCode: 'file->sessionID = thisSession'.
	self cCode: 'file->writable = 1'.
	self cCode: 'file->lastOp = 0'.
	interpreterProxy pop: 2; push: fileOop
