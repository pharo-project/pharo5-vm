inlining
pruneMethods: selectorList
	"Explicitly prune some methods"
	selectorList do: [:sel| self removeMethodForSelector: sel]