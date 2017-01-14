memory space primitives
primitiveSetGCSemaphore
	"Primitive. Indicate the semaphore to be signalled for upon garbage collection"
	| index |
	<export: true>
	index := self stackIntegerValue: 0.
	self successful ifTrue:[
		gcSemaphoreIndex := index.
		self pop: argumentCount.
	]