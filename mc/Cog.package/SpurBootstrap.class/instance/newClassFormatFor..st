bootstrap image
newClassFormatFor: oldClassObj
	"OLD: 		<2 bits=instSize//64><5 bits=cClass><4 bits=instSpec><6 bits=instSize\\64><1 bit=0>
	 NEW: 		<5 bits inst spec><16 bits inst size>"
	| oldFormat instSize newInstSpec |
	((oldInterpreter classNameOf: oldClassObj Is: 'SmallInteger')
	 or: [(oldInterpreter classNameOf: oldClassObj Is: 'Character')
	 or: [oldInterpreter classNameOf: oldClassObj Is: 'SmallFloat64']]) ifTrue:
		[^newHeap integerObjectOf: newHeap instSpecForImmediateClasses << 16].
	oldFormat := oldHeap formatOfClass: oldClassObj. "N.B. SmallInteger with tag bit cleared"
	oldFormat := oldFormat >> 1.
	instSize := ((oldFormat bitShift: -10) bitAnd: 16rC0) + ((oldFormat bitShift: -1) bitAnd: 16r3F) - 1.
	newInstSpec := #(0 1 2 3 4 nil 10 9 16 16 16 16 24 24 24 24) at: ((oldFormat bitShift: -7) bitAnd: 16rF) + 1.
	^newHeap integerObjectOf: newInstSpec << 16 + instSize