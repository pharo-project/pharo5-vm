accessing
semaphoreIndices
	"An array of Smalltalk Semaphore indices, one for each signal type for which
	a handler has been set. If an entry is zero, then no handler is active."

	<returnTypeC: 'unsigned char *'>
	^ semaIndices