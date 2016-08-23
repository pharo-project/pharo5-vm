debug printing
printMethodDictionary: dictionary
	<api>
	| methodArray |
	methodArray := objectMemory fetchPointer: MethodArrayIndex ofObject: dictionary.
	SelectorStart to: (objectMemory numSlotsOf: dictionary) - 1 do:
		[:index | | selector meth |
		 selector := objectMemory fetchPointer: index ofObject: dictionary.
		 selector ~= objectMemory nilObject ifTrue:
			[meth := objectMemory fetchPointer: index - SelectorStart ofObject: methodArray.
			 self
				printOopShort: selector;
				print: ' => ';
				printOopShort: meth;
				print: ' (';
				printHex: selector;
				print: ' => ';
				printHex: meth;
				putchar: $);
				cr]]