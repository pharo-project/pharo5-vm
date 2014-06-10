accessing
objectFormatsMap
	"self objectFormatsMap"
	| map |
	map := Dictionary new.
	self selectorsAndMethodsDo:
		[:s :m| | mn |
		('*format*' match: s)
		and: [mn := m methodNode block.
			(mn statements size = 1
			 and: [mn statements first expr isConstantNumber]) ifTrue:
				[map at: mn statements first expr key put: s]]].
	^map keys sort collect:
		[:n|
		{ n. map at: n }]