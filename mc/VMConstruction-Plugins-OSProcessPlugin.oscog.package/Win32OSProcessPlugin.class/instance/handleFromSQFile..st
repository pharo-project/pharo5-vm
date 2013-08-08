private - handle conversion
handleFromSQFile: anSQFileRecord

	| sqFile |
	<returnTypeC: 'HANDLE'>
	<var: 'sqFile' type: 'SQFile *'>
	((interpreterProxy isBytes: anSQFileRecord) and:
			[(interpreterProxy stSizeOf: anSQFileRecord) = self fileRecordSize])
		ifFalse:
			[interpreterProxy primitiveFail.
			^ nil].
	sqFile := self fileValueOf: anSQFileRecord.
	^ self cCode: 'sqFile->file' inSmalltalk: [0]
