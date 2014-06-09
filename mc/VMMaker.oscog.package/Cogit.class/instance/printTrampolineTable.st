debugging
printTrampolineTable
	<api>
	0 to: trampolineTableIndex - 1 by: 2 do:
		[:i|
		coInterpreter
			printHex: (trampolineAddresses at: i + 1) asInteger;
			print: ': ';
			print: (self cCoerceSimple: (trampolineAddresses at: i) to: #'char *');
			cr]