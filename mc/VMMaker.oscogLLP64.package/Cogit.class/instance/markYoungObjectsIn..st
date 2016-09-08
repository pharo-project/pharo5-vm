garbage collection
markYoungObjectsIn: cogMethod
	"Mark young literals in the method."
	<var: #cogMethod type: #'CogMethod *'>
	<inline: true>
	self assert: (cogMethod cmType = CMMethod
				or: [cogMethod cmType = CMOpenPIC]).
	 (objectMemory isYoung: cogMethod selector) ifTrue:
		[objectMemory markAndTrace: cogMethod selector].
	(cogMethod cmType = CMMethod
	 and: [objectMemory isYoung: cogMethod methodObject]) ifTrue:
		[objectMemory markAndTrace: cogMethod methodObject].
	self mapFor: cogMethod
		 performUntil: #markYoungObjects:pc:method:
		 arg: cogMethod asInteger