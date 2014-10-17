error handling
reportPrimitiveFailure
	| errorAndLog |
	errorAndLog := self primitiveErrorAndLog.
	self error: 'Error ', errorAndLog first printString, (errorAndLog last ifNil: [''] ifNotNil: [:log| ': ', log])