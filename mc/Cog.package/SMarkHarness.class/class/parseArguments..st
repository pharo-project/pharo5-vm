helper
parseArguments: arguments
	| parser |
	parser := self defaultArgumentParser new.
	parser harness: self.
	^ parser parse: arguments.