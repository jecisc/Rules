"
A RuRuleTest is a test class for testing the behavior of RuRule
"
Class {
	#name : #RuRuleTest,
	#superclass : #RuAbstractRuleTest,
	#category : #'Rules-Tests'
}

{ #category : #helpers }
RuRuleTest >> actualClass [
	^ RuRule
]

{ #category : #helpers }
RuRuleTest >> mutate: aRule [
	aRule ruleBlock: [ :aModel | aModel allContainers select: [ :each | each numberOfLinesOfCode > 100 ] ]
]

{ #category : #helpers }
RuRuleTest >> newInstance [
	^ super newInstance
		label: 'Long Containers';
		explanation: 'Containers should not be longer than 10 lines of code';
		ruleBlock: [ :aModel | aModel allContainers select: [ :each | each numberOfLinesOfCode > 6 ] ];
		remediationTime: 10;
		yourself
]

{ #category : #helpers }
RuRuleTest >> totalRemediationTime [
	^ Duration minutes: 30
]
