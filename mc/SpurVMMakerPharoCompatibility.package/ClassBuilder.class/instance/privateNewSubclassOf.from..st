private
privateNewSubclassOf: newSuper from: oldClass
	"Create a new meta and non-meta subclass of newSuper using oldClass as template"
	"WARNING: This method does not preserve the superclass/subclass invariant!"
	| newSuperMeta oldMeta newMeta |
	oldClass ifNil:[^self privateNewSubclassOf: newSuper].
	newSuperMeta := newSuper ifNil:[Class] ifNotNil:[newSuper class].
	oldMeta := oldClass class.
	newMeta := oldMeta shallowCopy.
	newMeta 
		superclass: newSuperMeta
		methodDictionary: MethodDictionary new
		format: (self computeFormat: oldMeta typeOfClass 
					instSize: oldMeta instVarNames size 
					forSuper: newSuperMeta
					ccIndex: 0);
		setInstVarNames: oldMeta instVarNames;
		organization: oldMeta organization.
	"Recompile the meta class"
	oldMeta hasMethods 
		ifTrue:[newMeta compileAllFrom: oldMeta].
	"Record the meta class change"
	self recordClass: oldMeta replacedBy: newMeta.
	"And create a new instance"
	^newMeta adoptInstance: oldClass from: oldMeta