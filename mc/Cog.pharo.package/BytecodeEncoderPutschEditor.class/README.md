I am a MethodNode that uses the size and emit methods that use the BytecodeEncoder hierarchy's bytecode generation facilities.  This means my nodes no longer need encode specifics about the bytecode set.

To compile edited versions of the size* and emit* methods use
	BytecodeEncoderPutschEditor new edit

In 3.8:
To get the source of the new version of MethodNode>>generate: for BytecodeAgnosticMethodNode use
BytecodeEncoderPutschEditor new
	editCode: (MethodNode sourceCodeAt: #generate:) asString
	inClass: BytecodeAgnosticMethodNode
	withSelector: #generate:

In 3.9:
To get the source of the new version of MethodNode>>generateWith:using: for BytecodeAgnosticMethodNode use
BytecodeEncoderPutschEditor new
	editCode: (BytecodeAgnosticMethodNode sourceCodeAt: #generateWith:using:) asString
	inClass: BytecodeAgnosticMethodNode
	withSelector: #generateWith:using: