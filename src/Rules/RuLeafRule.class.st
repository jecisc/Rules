"
Description
-------------------

I am an abstract leaf rule. I know how many time I need to correct a problem but my subclasses should define how to find my violations. From the violations, I can return the time needed to correct the problems of a rule. 

I use a caching system to remember the time I need to correct those problem but the cache should be reset if the way to find the violations change. 

Public API and Key Messages
--------------------
- #remediationTime 		Return a Duration corresponding to the time to correct one entities breaking the rule.
- #totalRemediationTime 		Return a Duration corresponding to the time to correct all the entities breaking the rule.
		
Example
------------------
	
	See my subclasses

Internal Representation and Key Implementation Points.
------------------

    Instance Variables
	remediationTime:		<aDuration> 				The duration to correct one infraction.
	violationsCache:		<anIntegerOrNil>		A cache to save all the entities breaking a rule.


"
Class {
	#name : #RuLeafRule,
	#superclass : #RuAbstractRule,
	#instVars : [
		'estimatedRemediationTime',
		'violationsCache'
	],
	#category : #'Rules-Model'
}

{ #category : #testing }
RuLeafRule class >> isAbstract [
	<ignoreForCoverage>
	^ self = RuLeafRule
]

{ #category : #comparing }
RuLeafRule >> = anObject [
	^ super = anObject
		and: [ self remediationTime = anObject remediationTime ]
]

{ #category : #accessing }
RuLeafRule >> computeViolations [
	^ self subclassResponsibility
]

{ #category : #comparing }
RuLeafRule >> hash [
	^ super hash bitXor: self remediationTime hash
]

{ #category : #initialization }
RuLeafRule >> initialize [
	super initialize.
	self remediationTime: 30 minutes
]

{ #category : #accessing }
RuLeafRule >> remediationDuration [
	self deprecated: 'Use #remediationTime instead.' transformWith: '`@receiver remediationDuration' -> '`@receiver remediationTime'.
	^ self remediationTime
]

{ #category : #accessing }
RuLeafRule >> remediationTime [
	^ estimatedRemediationTime
]

{ #category : #accessing }
RuLeafRule >> remediationTime: aDuration [
	estimatedRemediationTime := aDuration asRuleDuration
]

{ #category : #accessing }
RuLeafRule >> remediationTimeInDays [
	^ self remediationTime asMinutes / self workingHours / 60
]

{ #category : #initialization }
RuLeafRule >> resetCache [
	self violationsCache: nil
]

{ #category : #memento }
RuLeafRule >> restoreFromMemento: aMemento [
	super restoreFromMemento: aMemento.
	self remediationTime: aMemento remediationTime
]

{ #category : #accessing }
RuLeafRule >> result [
	self deprecated: 'Use #violations instead' transformWith: '`@receiver result' -> '`@receiver violations'.
	^ self violations
]

{ #category : #accessing }
RuLeafRule >> totalRemediationTime [
	^ self remediationTime * self violations size
]

{ #category : #accessing }
RuLeafRule >> violations [
	^ self violationsCache
		ifNil: [ 
			self violationsCache: self computeViolations.
			self violationsCache ]
]

{ #category : #accessing }
RuLeafRule >> violationsCache [
	^ violationsCache
]

{ #category : #accessing }
RuLeafRule >> violationsCache: anObject [
	violationsCache := anObject
]
