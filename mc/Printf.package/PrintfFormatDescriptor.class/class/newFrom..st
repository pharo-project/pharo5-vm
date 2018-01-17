instance creation
newFrom: desc
	| myself |
	myself := self new.
	myself perform: desc flush.
	myself width: desc width.
	myself precision: desc precision.
	^ myself