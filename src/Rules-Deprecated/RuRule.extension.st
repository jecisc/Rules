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

{ #category : #'*Rules-Deprecated' }
RuRule class >> ruleBlock: aBlock label: aString explanation: aMeaningString remediationTime: anInteger [
	self
		deprecated: 'Use #rule:label:explanation:remediationTime: instead'
		transformWith:
			'`@receiver ruleBlock: `@arg1 label: `@arg2 explanation: `@arg3 remediationTime: `@arg4'
				-> '`@receiver rule: `@arg1 label: `@arg2 explanation: `@arg3 remediationTime: `@arg4'.
	^ self
		rule: aBlock
		label: aString
		explanation: aMeaningString
		remediationTime: anInteger
]
