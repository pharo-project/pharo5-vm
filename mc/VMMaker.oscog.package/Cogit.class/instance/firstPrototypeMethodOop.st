in-line cacheing
firstPrototypeMethodOop
	"Answer a fake value for the first method oop in the PIC prototype.
	 Since we use MoveUniqueCw:R: it must not be confused with a method-relative address."
	<inline: false>
	^(self addressIsInCurrentCompilation: 16r5EAF00D)
		ifTrue: [16rCA7F00D]
		ifFalse: [16r5EAF00D]