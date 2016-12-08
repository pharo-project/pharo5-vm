in-line cacheing
subsequentPrototypeMethodOop
	"Answer a fake value for the method oop in other than the first case in the PIC prototype.
	 Since we use MoveUniqueCw:R: it must not be confused with a method-relative address."
	<inline: false>
	^(self addressIsInCurrentCompilation: 16rBADA550)
		ifTrue: [16rDEADEAD]
		ifFalse: [16rBADA550]