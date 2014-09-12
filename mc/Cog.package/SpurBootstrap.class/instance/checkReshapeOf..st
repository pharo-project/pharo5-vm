bootstrap image
checkReshapeOf: ourMethodClasses
	"Check the shape of all our method classes match the shape of those in the image to be bootstrapped.
	 Use the simulator to redefine any that need it.  Does /not/ reshape metaclasses; these we assume are ok."
	| toReshape |
	toReshape := Set new.
	ourMethodClasses do:
		[:mc|
		(literalMap at: mc binding ifAbsent: []) ifNotNil:
			[:binding|
			(mc ~~ Character "Character will reshape anyway"
			 and: [mc instSize ~= (oldHeap instanceSizeOf: (oldHeap fetchPointer: ValueIndex ofObject: binding))]) ifTrue:
				[toReshape add: mc]]].
	toReshape isEmpty ifTrue:
		[^self].
	self interpreter: oldInterpreter
			object: (self oldClassOopFor: ClassBuilder)
			perform: (self findSymbol: #beSilent:)
			withArguments: {oldHeap trueObject}.
	"Assume only one class in any subtree needs reshaping.  Fast and loose but gets us there for now."
	toReshape copy do:
		[:class|
		toReshape removeAll: (toReshape select: [:ea| ea inheritsFrom: class])].
	toReshape do:
		[:class|
		Transcript cr;  nextPutAll: 'RESHAPING '; print: class; flush.
		self interpreter: oldInterpreter
			object: (self oldClassOopFor: Compiler)
			perform: (self findSymbol: #evaluate:)
			withArguments: {oldHeap stringForCString: class definition}]