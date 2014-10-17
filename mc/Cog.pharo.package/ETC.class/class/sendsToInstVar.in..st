utilities
sendsToInstVar: instVarName in: class
	"Answer all selectors sent to instVarName in class's methods"
	| idx ref selectors |
	idx := class instVarIndexFor: instVarName ifAbsent: [^Set new].
	ref := {#inst. idx}.
	selectors := Set new.
	class methodsDo:
		[:m| selectors addAll: ((self sendsForMethod: m) at: ref ifAbsent: [#()])].
	^selectors