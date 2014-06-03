garbage collection
followForwardedLiteralsIn: cogMethod
	<api>
	<option: #SpurObjectMemory>
	<var: #cogMethod type: #'CogMethod *'>
	self assert: (objectMemory shouldRemapOop: cogMethod methodObject) not.
	(objectMemory shouldRemapOop: cogMethod selector) ifTrue:
		[cogMethod selector: (objectMemory remapObj: cogMethod selector)].
	self mapFor: cogMethod
		performUntil: #remapIfObjectRef:pc:hasYoung:
		arg: 0