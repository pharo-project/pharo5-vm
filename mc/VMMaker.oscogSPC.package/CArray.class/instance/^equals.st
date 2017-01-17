comparing
= anObject
	^self species = anObject species
	  and: [(1 to: self class instSize) allSatisfy:
			[:i| (self instVarAt: i) = (anObject instVarAt: i)]]