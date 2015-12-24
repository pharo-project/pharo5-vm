simulation only
breakBlock: aBlock
	<doNotGenerate>
	breakBlock := aBlock.
	singleStep := singleStep or: [breakPC singleStepRequiredToTriggerIn: self]