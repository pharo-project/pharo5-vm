interpreter interface
isIdentityMap: shifts with: masks
	"Return true if shiftTable/maskTable define an identity mapping."
	<var: #shifts type:'int *'>
	<var: #masks type:'unsigned int *'>
	(shifts == nil or:[masks == nil]) ifTrue:[^true].
	((shifts at: RedIndex) = 0 
		and:[(shifts at: GreenIndex) = 0
		and:[(shifts at: BlueIndex) = 0 
		and:[(shifts at: AlphaIndex) = 0
			and:[((masks at: RedIndex) = 16rFF0000)
			and:[((masks at: GreenIndex) = 16r00FF00)
			and:[((masks at: BlueIndex) = 16r0000FF)
			and:[((masks at: AlphaIndex) = 16rFF000000)]]]]]]])
		ifTrue:[^true].
	^false