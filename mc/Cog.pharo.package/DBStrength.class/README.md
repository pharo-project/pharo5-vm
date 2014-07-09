Strengths are used to measure the relative importance of constraints. The hierarchy of available strengths is determined by the class variable StrengthTable (see my class initialization method). Because Strengths are invariant, references to Strength instances are shared (i.e. all references to
"Strength of: #required" point to a single, shared instance). New strengths may be inserted in the strength hierarchy without disrupting current constraints.

Instance variables:
	symbolicValue		symbolic strength name (e.g. #required) <Symbol>
	arithmeticValue		index of the constraint in the hierarchy, used for comparisons <Number>