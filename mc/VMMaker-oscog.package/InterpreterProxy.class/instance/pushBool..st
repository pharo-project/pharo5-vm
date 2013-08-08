stack access
pushBool: trueOrFalse
	(trueOrFalse == true or:[trueOrFalse == false]) ifFalse:[self error:'Not a Boolean'].
	self push: trueOrFalse