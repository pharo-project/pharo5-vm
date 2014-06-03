A SpurCircularBuffer is a region of memory being used as a circular buffer.  The buffer is empty when last < start.  The buffer is full when first = (last + wordSize > limit ifTrue: [start] ifFalse: [last + wordSize]).

Instance Variables
	first:		<Integer address>
	last:		<Integer address>

first
	- pointer to the first element in the buffer

last
	- pointer to the last element in the buffer
