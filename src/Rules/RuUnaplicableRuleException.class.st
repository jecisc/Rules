Class {
	#name : #RuUnaplicableRuleException,
	#superclass : #Error,
	#instVars : [
		'cachedError',
		'rule',
		'model'
	],
	#category : #'Rules-Exceptions'
}

{ #category : #signaling }
RuUnaplicableRuleException class >> signalForRule: aRule model: aCollection cachedError: anError [
	self new
		rule: aRule;
		model: aCollection;
		cachedError: anError;
		signal
]

{ #category : #accessing }
RuUnaplicableRuleException >> cachedError [
	^ cachedError
]

{ #category : #accessing }
RuUnaplicableRuleException >> cachedError: anObject [
	cachedError := anObject
]

{ #category : #accessing }
RuUnaplicableRuleException >> messageText [
	^ 'The computation of the rule "{1}" failed on {2}.
Error: 
{3}' format: {rule label . model printString . cachedError signalerContext shortStack}
]

{ #category : #accessing }
RuUnaplicableRuleException >> model: anObject [
	model := anObject
]

{ #category : #accessing }
RuUnaplicableRuleException >> rule: anObject [
	rule := anObject
]
