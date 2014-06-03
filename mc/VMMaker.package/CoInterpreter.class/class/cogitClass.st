translation
cogitClass
	"CogitClass := SimpleStackBasedCogit"
	"CogitClass := StackToRegisterMappingCogit"
	CogitClass isNil ifTrue: [CogitClass := SimpleStackBasedCogit].
	^CogitClass