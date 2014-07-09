validation
validateSubclass: subclass canKeepLayoutFrom: oldClass forSubclassFormat: newType 
	"Returns whether the immediate subclasses of oldClass can keep its layout"
	"Note: Squeak does not appear to model classFormat relationships.. so I'm putting some logic here. bkv 4/2/2003"
	
	"Only run this test for a real subclass - otherwise this prevents changing
	a class from #subclass: to #variableSubclass: etc."
	subclass = oldClass ifTrue:[^true].

	 "isWeak implies isVariant"					
	 (oldClass isVariable and: [ subclass isWeak ])
		ifFalse: [ "In general we discourage format mis-matches"
				  (subclass typeOfClass == newType) 
				   	ifFalse: [ self error: subclass name,' cannot be recompiled'.
							  ^ false ]].
	^ true