class initialization
initialize
	"PrintfFormatDescriptor initialize"
	Operators := Dictionary new.
	Operators at: $P put: #PrintStringFormatDescriptor.
	Operators at: $c put: #PrintfCharacterFormatDescriptor.
	Operators at: $s put: #PrintfStringFormatDescriptor.
	#($d $o $u $x $X $p)
		do: [:operator | Operators at: operator put: #PrintfNumberFormatDescriptor].
	#($e $E $f $g $G $a $A)
		do: [:operator | Operators at: operator put: #PrintfFloatFormatDescriptor].

	Flags := Dictionary new.
	Flags at: $- put: #leftFlush.
	Flags at: $+ put: #rightFlush.
	Flags at: $  put: #space.
	Flags at: $# put: #radix.
	Flags at: $0 put: #zero