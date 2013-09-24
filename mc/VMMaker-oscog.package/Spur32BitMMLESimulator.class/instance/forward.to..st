become
forward: obj1 to: obj2
	"(obj1 = 16r150CD8 or: [obj1 = 16r1510B8
	 or: [obj2 = 16r150CD8 or: [obj2 = 16r1510B8]]]) ifTrue:
		[self halt]."
	^super forward: obj1 to: obj2