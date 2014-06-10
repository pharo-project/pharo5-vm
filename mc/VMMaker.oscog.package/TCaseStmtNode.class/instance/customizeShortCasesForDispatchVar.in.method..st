transformations
customizeShortCasesForDispatchVar: varName in: codeGen method: aTMethod
	"Make customized versions of short bytecode methods, substituting a constant having the case index value for the given variable.
	 This produces better code for short bytecodes such as instance variable pushes that encode the index of the instance variable in the bytecode."

	| newFirsts newLasts newCases seen |
	newFirsts := OrderedCollection new.
	newLasts := OrderedCollection new.
	newCases := OrderedCollection new.
	seen := Set new.	"So that sharedCodeNamed:inCase:'s can be used in multiple bytecode set
						 configurations we need to expand the code only once."
	1 to: cases size do:
		[ :i | | l f case expanded |
		l := lasts at: i.
		f := firsts at: i.
		case := cases at: i.
		expanded := false.
		((l - f) > 1  "case code covers multiple cases"
		 and: [case shouldExpand]) ifTrue:
				[newFirsts addAll: (f to: l) asArray.
				 newLasts addAll: (f to: l) asArray.
				 newCases addAll: (self customizeCase: case forVar: varName from: f to: l in: codeGen method: aTMethod expandedCases: seen).
				 expanded := true].
		expanded ifFalse:
			[self processSharedCodeBlocks: case forCase: f in: codeGen method: aTMethod expandedCases: seen.
			 newFirsts addLast: f.
			 newLasts addLast: l.
			 newCases addLast: case]].
	firsts := newFirsts asArray.
	lasts := newLasts asArray.
	cases := newCases asArray