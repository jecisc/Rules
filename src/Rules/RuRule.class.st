"
Description
-------------------

I am a concrete rule. I know how many time I need to correct a problem and I know how to find the number of entities breaking a rule in a model. From this I can return the time needed to correct the problems of a rule. 

I use a caching system to remember the time I need to correct those problem but the cache will be reset if the computation block or the model change. 

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
	remediationTime:		<anInteger> 				The number of minutes to correct one infraction.
	resultCache:				<anIntegerOrNil>		A cache to save all the entities breaking a rule.
	ruleBlock:				<aBlock>					A block returning all the entities breaking the rule.


"
Class {
	#name : #RuRule,
	#superclass : #RuAbstractRule,
	#instVars : [
		'remediationTime',
		'ruleBlock',
		'resultCache'
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

{ #category : #comparing }
RuRule >> = anObject [
	^ super = anObject
		and: [ self remediationTime = anObject remediationTime ]
]

{ #category : #accessing }
RuRule >> children [
	^ {}
]

{ #category : #accessing }
RuRule >> computeResult [
	^ [ self ruleBlock value: self model ]
		on: Error
		do: [ :e | RuUnaplicableRuleException signalForRule: self model: self model cachedError: e ]
]

{ #category : #memento }
RuRule >> createMemento [
	^ self copy
]

{ #category : #comparing }
RuRule >> hash [
	^ super hash bitXor: self remediationTime hash
]

{ #category : #initialization }
RuRule >> initialize [
	super initialize.
	self remediationTime: 30
]

{ #category : #accessing }
RuRule >> remediationDuration [
	^ Duration minutes: self remediationTime
]

{ #category : #accessing }
RuRule >> remediationTime [
	^ remediationTime
]

{ #category : #accessing }
RuRule >> remediationTime: anObject [
	remediationTime := anObject
]

{ #category : #accessing }
RuRule >> remediationTimeInDays [
	^ self remediationTime / self workingHours / 60
]

{ #category : #initialization }
RuRule >> resetCache [
	self resultCache: nil
]

{ #category : #memento }
RuRule >> restoreFromMemento: aMemento [
	self label: aMemento label.
	self remediationTime: aMemento remediationTime
]

{ #category : #accessing }
RuRule >> result [
	^ self resultCache
		ifNil: [ 
			self resultCache: self computeResult.
			self resultCache ]
]

{ #category : #accessing }
RuRule >> resultCache [
	^ resultCache
]

{ #category : #accessing }
RuRule >> resultCache: anObject [
	resultCache := anObject
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

{ #category : #accessing }
RuRule >> totalRemediationTime [
	^ self remediationDuration * self result size
]

{ #category : #accessing }
RuRule >> workingHours [
	^ 8
]
