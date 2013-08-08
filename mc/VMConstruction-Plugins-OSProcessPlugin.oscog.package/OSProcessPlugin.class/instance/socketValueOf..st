private - SQSocket access
socketValueOf: anSQSocketRecord
	"Return a pointer to the first byte of of the SQsocket data structure socket record within
	anSQSocketRecord, which is expected to be a ByteArray of size self>>socketRecordSize."

	<returnTypeC: 'SocketPtr'>
	^ interpreterProxy arrayValueOf: anSQSocketRecord
