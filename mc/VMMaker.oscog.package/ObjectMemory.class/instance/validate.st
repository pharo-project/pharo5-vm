simulation
validate
	"Validate all the objects in the heap."
	self cCode: [] inSmalltalk: [
	| oop prev |
	self interpreter transcript show: 'Validating...'.
	oop := self firstObject.
	[oop < endOfMemory] whileTrue: [
		self validate: oop.
		prev := oop.  "look here if debugging prev obj overlapping this one"
		oop := self objectAfter: oop.
	].
	self touch: prev.  "Don't offer to delete this please"
	self interpreter transcript show: 'done.'; cr]