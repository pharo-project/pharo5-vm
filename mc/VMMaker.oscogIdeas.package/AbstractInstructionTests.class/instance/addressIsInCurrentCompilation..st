cogit compatibility
addressIsInCurrentCompilation: address
	"Provide a range of addresses that are assumed to be in the current compilation.  Within this range operands
	 can be interpreted as pc-relative addresses, and hence allow testing of pc-relative addresses,"
	^self currentCompilationBase <= address
	  and: [address - self currentCompilationBase < 1024]