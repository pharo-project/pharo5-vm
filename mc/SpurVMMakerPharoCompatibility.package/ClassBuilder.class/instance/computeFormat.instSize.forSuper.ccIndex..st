class format
computeFormat: type instSize: newInstSize forSuper: newSuper ccIndex: ccIndex
	"Compute the new format for making oldClass a subclass of newSuper.
	Return the format or nil if there is any problem."
	| instSize isVar isWords isPointers isWeak |
	type == #compiledMethod ifTrue:
		[
		"we ensure that compiled method subclasses have as compat class index the one we receive as a argument"
		^(CompiledMethod format
			bitClear: (16r1F bitShift: 11))
				bitOr: (ccIndex bitShift: 11)].
	instSize := newInstSize + (newSuper ifNil:[0] ifNotNil:[newSuper instSize]).
	instSize > 254 ifTrue:
		[self error: 'Class has too many instance variables (', instSize printString,')'.
		^nil].
	type == #normal ifTrue:[isVar := isWeak := false. isWords := isPointers := true].
	type == #bytes ifTrue:[isVar := true. isWords := isPointers := isWeak := false].
	type == #words ifTrue:[isVar := isWords := true. isPointers := isWeak := false].
	type == #variable ifTrue:[isVar := isPointers := isWords := true. isWeak := false].
	type == #weak ifTrue:[isVar := isWeak := isWords := isPointers := true].
	(isPointers not and:[instSize > 0]) ifTrue:
		[self error:'A non-pointer class cannot have instance variables'.
		^nil].
	^(self format: instSize 
		variable: isVar 
		words: isWords 
		pointers: isPointers 
		weak: isWeak) + (ccIndex bitShift: 11).