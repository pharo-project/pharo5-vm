garbage collection
followForwardedLiteralsIn: cogMethod
	<api>
	<option: #SpurObjectMemory>
	<var: #cogMethod type: #'CogMethod *'>
	self assert: (cogMethod cmType ~= CMMethod or: [(objectMemory isForwarded: cogMethod methodObject) not]).
	(objectMemory shouldRemapOop: cogMethod selector) ifTrue:
		[cogMethod selector: (objectMemory remapObj: cogMethod selector).
		 (objectMemory isYoung: cogMethod selector) ifTrue:
			[methodZone ensureInYoungReferrers: cogMethod]].
	self mapFor: cogMethod
		performUntil: #remapIfObjectRef:pc:hasYoung:
		arg: 0