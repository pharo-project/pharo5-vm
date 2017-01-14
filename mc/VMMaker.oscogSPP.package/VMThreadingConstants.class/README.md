VMThreadingConstants ensureClassPool.
CogThreadManager classPool keys do:
	[:k| VMThreadingConstants classPool declare: k from: CogThreadManager classPool].
CoInterpreterMT classPool keys do:
	[:k| VMThreadingConstants classPool declare: k from: CoInterpreterMT classPool].