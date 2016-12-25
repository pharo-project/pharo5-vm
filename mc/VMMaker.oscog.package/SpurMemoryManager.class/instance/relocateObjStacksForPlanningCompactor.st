compaction
relocateObjStacksForPlanningCompactor
	"Relocate all non-empty objStack pages, following the objStacks from the roots."

	markStack := self relocateObjStackForPlanningCompactor: markStack.
	weaklingStack := self relocateObjStackForPlanningCompactor: weaklingStack.
	mournQueue := self relocateObjStackForPlanningCompactor: mournQueue