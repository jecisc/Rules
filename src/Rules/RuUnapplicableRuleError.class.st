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
	#name : #RuUnapplicableRuleError,
	#superclass : #Error,
	#instVars : [
		'cachedError',
		'rule',
		'model'
	],
	#category : #'Rules-Exceptions'
}

{ #category : #signaling }
RuUnapplicableRuleError class >> signalForRule: aRule model: aCollection cachedError: anError [
	self new
		rule: aRule;
		model: aCollection;
		cachedError: anError;
		signal
]

{ #category : #accessing }
RuUnapplicableRuleError >> cachedError [
	^ cachedError
]

{ #category : #accessing }
RuUnapplicableRuleError >> cachedError: anObject [
	cachedError := anObject
]

{ #category : #accessing }
RuUnapplicableRuleError >> messageText [
	^ 'The computation of the rule "{1}" failed on {2}.
Error: 
{3}' format: {rule label . model printString . cachedError signalerContext shortStack}
]

{ #category : #accessing }
RuUnapplicableRuleError >> model: anObject [
	model := anObject
]

{ #category : #accessing }
RuUnapplicableRuleError >> rule: anObject [
	rule := anObject
]
