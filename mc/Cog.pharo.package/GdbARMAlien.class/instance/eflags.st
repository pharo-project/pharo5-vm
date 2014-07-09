accessing
eflags
	
	^ (((self nflag << 5 bitOr: self zflag << 4) 
			bitOr: self cflag << 3) 
				bitOr: self vflag << 2)
					bitOr: self ifflags