simulation only
breakBlock: aBlock
	<doNotGenerate>
	breakBlock := aBlock.
	breakPC ifNil: [breakPC := true].
	singleStep := singleStep or: [breakPC singleStepRequiredToTriggerIn: self]