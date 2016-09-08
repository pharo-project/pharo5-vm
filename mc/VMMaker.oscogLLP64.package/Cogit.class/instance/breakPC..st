simulation only
breakPC: anAddressArrayOrNil
	<doNotGenerate>
	breakPC := anAddressArrayOrNil.
	singleStep := singleStep or: [anAddressArrayOrNil singleStepRequiredToTriggerIn: self]