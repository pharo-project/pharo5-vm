instance creation
from: start to: stop cogMethod: cogMethod startpc: startpc
	^(super from: start to: stop)
		cogMethod: cogMethod;
		startpc: startpc;
		yourself