Extension { #name : #RuLeafRule }

{ #category : #'*Rules-Deprecated' }
RuLeafRule >> remediationDuration [
	self deprecated: 'Use #remediationTime instead.' transformWith: '`@receiver remediationDuration' -> '`@receiver remediationTime'.
	^ self remediationTime
]

{ #category : #'*Rules-Deprecated' }
RuLeafRule >> result [
	self deprecated: 'Use #violations instead' transformWith: '`@receiver result' -> '`@receiver violations'.
	^ self violations
]
