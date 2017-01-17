rcvr linkage
allocateStringAndSetRcvrErrorStrFromCStr: aCStrBuffer

	|length errorStrObj errorStrObjPtr |
	<var: #aCStrBuffer type: 'const char *'>
	<var: #errorStrObjPtr type: 'void *'>
	"Allocate errorStrObj"
	length := self cCode: 'strlen(aCStrBuffer)'.
	errorStrObj := interpreterProxy
				instantiateClass: (interpreterProxy classString) 
				indexableSize: length.
	self loadRcvrFromStackAt: 0. "Assume garbage collection after instantiation"

	"Copy aCStrBuffer to errorStrObj's buffer"
	errorStrObjPtr := interpreterProxy arrayValueOf: errorStrObj.	
	self cCode:'memcpy(errorStrObjPtr,aCStrBuffer,length)'.
	self touch: errorStrObjPtr; touch: errorStrObj.
	"Set rcvrErrorStr from errorStrObj and Return"
	self rcvrErrorStrFrom: errorStrObj.
	^errorStrObj.