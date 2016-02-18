image segment in/out
imageSegmentVersion
	| wholeWord |
	"a more complex version that tells both the word reversal and the endianness of the machine
	 it came from.  Low half of word is e.g. 6521.  Top byte is top byte of #doesNotUnderstand: on
	 this machine. ($d on the Mac or $s on the PC)"

	wholeWord := self long32At: (self splObj: SelectorDoesNotUnderstand) + self baseHeaderSize. "first data word, 'does'"
	^coInterpreter imageFormatVersion bitOr: (wholeWord bitAnd: 16rFF000000)