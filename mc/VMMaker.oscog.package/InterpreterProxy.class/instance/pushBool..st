stack access
pushBool: trueOrFalse
	<returnTypeC: #sqInt>
	(trueOrFalse == true or:[trueOrFalse == false]) ifFalse:[self error:'Not a Boolean'].
	self push: trueOrFalse