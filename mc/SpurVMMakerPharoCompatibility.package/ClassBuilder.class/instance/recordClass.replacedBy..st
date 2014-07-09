private
recordClass: oldClass replacedBy: newClass
	"Keep the changes up to date when we're moving instVars around"
	(instVarMap includesKey: oldClass name) ifTrue:[
		SystemAnnouncer uniqueInstance classDefinitionChangedFrom: oldClass to: newClass.
	].