simulation only
methodsDo: aBlock
	<doNotGenerate>
	| cogMethod |
	cogMethod := cogit cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[cogMethod cmType ~= CMFree ifTrue:
			[aBlock value: cogMethod].
		 cogMethod := self methodAfter: cogMethod]
	"<api>
	<returnTypeC: #void>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := cogit cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[cogMethod cmType ~= CMFree ifTrue:
			[aBlock value: cogMethod].
		 cogMethod := self methodAfter: cogMethod]"