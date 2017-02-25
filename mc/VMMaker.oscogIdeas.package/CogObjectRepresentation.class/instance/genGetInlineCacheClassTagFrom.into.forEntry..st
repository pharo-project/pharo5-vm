compile abstract instructions
genGetInlineCacheClassTagFrom: sourceReg into: destReg forEntry: forEntry
	"Extract the inline cache tag for the object in sourceReg into destReg. The inline cache tag
	 for a given object is the value loaded in inline caches to distinguish objects of different
	 classes. If forEntry is true answer the entry label at which control is to enter (cmEntryOffset).
	 If forEntry is false, control enters at the start."
	<returnTypeC: #'AbstractInstruction *'>
	self subclassResponsibility