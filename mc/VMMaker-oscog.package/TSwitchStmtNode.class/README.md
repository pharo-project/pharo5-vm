I implement a Smalltalk
	foo caseOf: { [IntegerConstant | GlobalVariable] -> [expr] }
statement converting it into a C switch statement.  I make some effort to discover identical right-hand-side cases.