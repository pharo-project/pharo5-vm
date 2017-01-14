object enumeration
accessibleObjectAfter: oop 
	"Return the accessible object following the given object or 
	free chunk in the heap. Return nil when heap is exhausted."
	| obj |
	<inline: false>
	obj := self objectAfter: oop.
	[self oop: obj isLessThan: endOfMemory]
		whileTrue: [(self isFreeObject: obj) ifFalse: [^ obj].
			obj := self objectAfter: obj].
	^ nil