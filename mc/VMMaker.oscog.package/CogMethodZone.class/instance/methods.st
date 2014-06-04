simulation only
methods
	<doNotGenerate>
	| methods |
	methods := OrderedCollection new.
	self methodsDo:
		[:m| methods addLast: m].
	^methods