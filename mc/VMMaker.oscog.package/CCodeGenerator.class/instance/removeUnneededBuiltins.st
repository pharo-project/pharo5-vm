public
removeUnneededBuiltins
	| toRemove |
	toRemove := Set new: 64.
	methods keysDo:
		[:sel|
		(self isBuiltinSelector: sel) ifTrue:
			[(requiredSelectors includes: sel) ifFalse:
				[toRemove add: sel]]].
	toRemove do:
		[:sel| self removeMethodForSelector: sel]