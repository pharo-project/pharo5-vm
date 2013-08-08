private - file handles
dupToStdOut: anSQFileDataStructure
	"Dup a file descriptor to allow it to be attached as the standard output when we
	exec() a new executable. This is Unix specific, in that it assumes that file descriptor
	0 is stdin, 1 is stdout, and 2 is stderr. The dup2() call is used to copy the open file
	descriptors into file descriptors 0, 1 and 2 so that the image which we execute will
	use them as stdin, stdout, and stderr."

	| filenoToDup |
	<returnTypeC: 'void'>
	filenoToDup := self fileDescriptorFrom: anSQFileDataStructure.
	(filenoToDup < 0) ifFalse: [
		(filenoToDup = 1) ifFalse: [
			self cCode: 'fflush(stdout)'.
			self cCode: 'dup2(filenoToDup, 1)' ]]
