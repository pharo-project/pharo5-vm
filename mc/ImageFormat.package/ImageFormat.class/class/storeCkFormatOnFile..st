ckformat
storeCkFormatOnFile: fileName
	"Store source code for an image format version reader in a file. The program
	is intended for testing image file format from a unix shell script such that
	the shell script can decide what VM to run based on image requirements."

	| f |
	f := CrLfFileStream newFileNamed: fileName.
	[self generateCkFormatProgram: 'ckformat' on: f]
		ensure: [f ifNotNil: [f close]].
	^fileName