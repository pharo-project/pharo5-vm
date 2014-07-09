reporting
reportFor: aRunner on: aStream
	| reporter |
	reporter := self new.
	reporter runner: aRunner.
	reporter outputStream: aStream.
	reporter report.
	^ reporter.