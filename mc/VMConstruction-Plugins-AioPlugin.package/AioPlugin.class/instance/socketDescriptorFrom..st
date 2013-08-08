private - SQSocket access
socketDescriptorFrom: sqSocketOop
	"Answer the OS file descriptor, an integer value, from a SQSocket data structure,
	or answer -1 if unable to obtain the file descriptor (probably due to receiving
	an incorrect type of object as aFileHandle).

	Warning: The first element of privateSocketStruct happens to be the Unix file
	number of the socket. See sqUnixSocket.c for the definition. This method takes
	advantage of this, and will break if anyone ever redefines the data structure."

	| sqSocket privateSocketStruct |
	<returnTypeC: 'int'>
	<var: 'sqSocket' declareC: 'SQSocket *sqSocket'>
	<var: 'privateSocketStruct' declareC: 'void *privateSocketStruct'>
	sqSocket := self socketValueOf: sqSocketOop.
	privateSocketStruct := self cCode: 'sqSocket->privateSocketPtr'.
	privateSocketStruct = 0
		ifTrue: [^ -1].	"Something is wrong, bail out before we core dump."
	^ self cCode: '* (int *) privateSocketStruct' inSmalltalk: [-1].
