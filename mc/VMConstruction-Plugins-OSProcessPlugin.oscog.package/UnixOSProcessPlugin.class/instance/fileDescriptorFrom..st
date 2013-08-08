private - file handles
fileDescriptorFrom: aSQFileByteArray
	"Answer the OS file descriptor, an integer value, from a SQFile data structure
	byte array, or answer -1 if unable to obtain the file descriptor (probably due
	to receiving an incorrect type of object as aFileHandle)."

	"return type should be int, but skip the declaration to permit inlining"
	(self isSQFileObject: aSQFileByteArray) ifFalse: [^ -1].
	^ self fileno: (self fileHandleFrom: aSQFileByteArray)
