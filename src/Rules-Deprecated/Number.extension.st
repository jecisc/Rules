Extension { #name : #Number }

{ #category : #'*Rules-Deprecated' }
Number >> asRuleDuration [
	self deprecated: 'The user should directly give a duration and not a number to be sure of the unit.'.
	^ Duration minutes: self
]
