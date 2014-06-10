configurations
generateSqueakCogMTVM
	^self generateSqueakCogVMWithInterpreterClass: CoInterpreterMT
		  options: #(COGMTVM true)