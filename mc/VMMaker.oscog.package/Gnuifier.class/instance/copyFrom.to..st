as yet unclassified
copyFrom: inFileStream to: outFileStream

"convert interp.c to use GNU features"

|  inData |

	Cursor read showWhile:
		[inData := inFileStream upToEnd withSqueakLineEndings].
	Cursor write showWhile:
		[outFileStream nextPutAll: inData].
	outFileStream close