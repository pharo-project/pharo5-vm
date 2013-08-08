private - SQFile access
fileValueOf: anSQFileRecord
	"Return a pointer to the first byte of of the SQFile data structure file record within
	anSQFileRecord, which is expected to be a ByteArray of size self>>fileRecordSize."

	<returnTypeC: 'SQFile *'>
	^ interpreterProxy arrayValueOf: anSQFileRecord
