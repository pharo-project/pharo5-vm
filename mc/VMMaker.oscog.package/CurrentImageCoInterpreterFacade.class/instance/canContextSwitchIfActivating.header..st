accessing
canContextSwitchIfActivating: method header: header
	"Would like to do
		^coInterpreter canContextSwitchIfActivating: method header: header
	 but the bytecode access to get at the primitive number defeats us :-(, so
	 the following may well get out-of-date..."
	^(self objectForOop: method) primitive ~= 198