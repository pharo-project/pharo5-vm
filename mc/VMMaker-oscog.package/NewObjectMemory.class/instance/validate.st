simulation
validate
	"Validate all the objects in the heap.  This is a noop unless simulating, but is sent
	 so we need a null implementation when generating code."
	<cmacro: '() 0'>
	| oop prev |
	self interpreter transcript show: 'Validating...'.
	oop := self firstObject.
	[oop < freeStart] whileTrue:
		[self validate: oop.
		prev := oop.  "look here if debugging prev obj overlapping this one"
		oop := self objectAfter: oop].
	prev := prev.  "Don't offer to delete this please"
	self interpreter transcript show: 'done.'; cr