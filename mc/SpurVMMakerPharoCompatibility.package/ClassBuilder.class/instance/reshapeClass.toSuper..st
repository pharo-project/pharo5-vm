class mutation
reshapeClass: oldClass toSuper: newSuper
	"Reshape the given class to the new super class. Recompile all the methods in the newly created class. Answer the new class."
	| instVars |

	"ar 9/22/2002: The following is a left-over from some older code. 
	I do *not* know why we uncompact oldClass here. If you do, then 
	please let me know so I can put a comment here..."
	oldClass becomeUncompact.

	instVars := instVarMap at: oldClass name ifAbsent:[oldClass instVarNames].

	^self newSubclassOf: newSuper 
			type: oldClass typeOfClass 
			instanceVariables: instVars 
			from: oldClass