accessing
isUnconditionalBranch

	^self isBranch and: [(isBranchTrue or: [isBranchFalse]) not]