accessing
addressIsInCurrentCompilation: address 
	^self currentCompilationBase <= address
	  and: [address - self currentCompilationBase < 1024]