remembered set
setRefCountToShrinkRT: counts
	"Choose a refCount that will shrink the rt by at least  half."
	<var: 'counts' declareC: 'long counts[MaxRTRefCount + 1]'>
	<inline: true>
	| i count |
	count := 0.
	i := MaxRTRefCount + 1.
	[count < (rememberedSetSize // 2)  and: [(i := i - 1) >= 0]] whileTrue:
		[count := count + (counts at: i)].
	refCountToShrinkRT := i max: 0