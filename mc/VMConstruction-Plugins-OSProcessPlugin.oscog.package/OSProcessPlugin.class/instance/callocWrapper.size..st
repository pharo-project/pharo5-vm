private
callocWrapper: count size: objectSize
	"Using malloc() and calloc() is something I would like to avoid, since it is
	likely to cause problems some time in the future if somebody redesigns
	object memory allocation. This wrapper just makes it easy to find senders
	of calloc() in my code. -dtl"

	<returnTypeC: 'void *'>
	^ self cCode: 'calloc(count, objectSize)'