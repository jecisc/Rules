Extension { #name : #RuRule }

{ #category : #'*Rules-Deprecated' }
RuRule >> ruleBlock [
	self deprecated: 'Use #rule instead' transformWith: '`@receiver ruleBlock' -> '`@receiver rule'.
	^ self rule
]

{ #category : #'*Rules-Deprecated' }
RuRule >> ruleBlock: anObject [
	self deprecated: 'Use #rule: instead' transformWith: '`@receiver ruleBlock: `@arg' -> '`@receiver rule: `@arg'.
	self rule: anObject
]
