"
Description
--------------------

I am an error raised during the computation of a rule if an error occures.

Examples
--------------------

computeResult
	^ [ self inputQuery runOn: self model ]
		on: Error
		do: [ :e | RuUnaplicableRuleException signalForRule: self model: self model cachedError: e ]
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	cachedError:		<anException>	The exception raised and catched.
	model:				<anObject>		The model used to run the nule.
	rule:				<aRule>			The rule which failed.

"
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
