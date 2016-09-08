remembered set
setRefCountToShrinkRT: population
	"Choose a refCount that should shrink the rt by at least  half.
	 i.e. find the maximum reference count that half the population have at least."
	<var: 'population' declareC: 'long population[MaxRTRefCount + 1]'>
	<inline: true>
	| entirePopulation i count |
	self assert: (population at: 0) = 0.
	entirePopulation := 0.
	1 to: MaxRTRefCount do:
		[:j| entirePopulation := entirePopulation + (population at: j)].
	count := 0.
	i := MaxRTRefCount + 1.
	[count < (entirePopulation // 2) and: [(i := i - 1) >= 0]] whileTrue:
		[count := count + (population at: i)].
	refCountToShrinkRT := i max: 0