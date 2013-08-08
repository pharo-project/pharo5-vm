*CMakeVMMaker
generateFor: aCMakeVMGenerator internal: aBoolean 

	^ aCMakeVMGenerator 
		generatePlugin: self 
		internal: aBoolean
		extraRules: nil