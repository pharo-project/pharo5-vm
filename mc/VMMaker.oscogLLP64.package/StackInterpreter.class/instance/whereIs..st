debug printing
whereIs: anOop
	<api>
	<returnTypeC: 'char *'>
	<inline: false>
	<var: 'where' type: #'char *'>
	(objectMemory whereIsMaybeHeapThing: anOop) ifNotNil: [:where| ^where].
	(stackPages whereIsMaybeStackThing: anOop) ifNotNil: [:where| ^where].
	^' is no where obvious'