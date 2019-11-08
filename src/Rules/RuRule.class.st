"
Description
-------------------

I am a concrete leaf rule finding the violations to the rule via a block taking the model as parameter.

Public API and Key Messages
--------------------
- #remediationDuration 		Return a Duration corresponding to the time to correct one entities breaking the rule.
- #totalRemediationTime 		Return a Duration corresponding to the time to correct all the entities breaking the rule.
		
Example
------------------
	""Example on a model from Moose""

	(RuRootRule on: MooseModel new)
		addRule:
			(RuRule
				ruleBlock: [ :aModel | aModel allClasses select: [ :e | e numberOfLinesOfCode > 100 ] ]
				label: 'Methods too long'
				explanation: 'A class should not be too long'
				remediationTime: 45)
	
Internal Representation and Key Implementation Points.
------------------

    Instance Variables
	ruleBlock:				<aBlock>					A block returning all the entities breaking the rule.


"
Class {
	#name : #RuRule,
	#superclass : #RuLeafRule,
	#instVars : [
		'ruleBlock'
	],
	#category : #'Rules-Model'
}

{ #category : #'instance creation' }
RuRule class >> ruleBlock: aBlock label: aString explanation: aMeaningString remediationTime: anInteger [
	^ self new
		ruleBlock: aBlock;
		label: aString;
		explanation: aMeaningString;
		remediationTime: anInteger;
		yourself
]

{ #category : #accessing }
RuRule >> computeResult [
	^ [ self ruleBlock value: self model ]
		on: Error
		do: [ :e | RuUnaplicableRuleException signalForRule: self model: self model cachedError: e ]
]

{ #category : #accessing }
RuRule >> ruleBlock [
	^ ruleBlock
]

{ #category : #accessing }
RuRule >> ruleBlock: anObject [
	ruleBlock := anObject.
	self resetCache
]
