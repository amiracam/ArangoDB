Class {
	#name : #ArangoDatabase,
	#superclass : #Object,
	#instVars : [
		'client',
		'dbName',
		'currentCollection'
	],
	#category : #'Arango-Core-Base'
}

{ #category : #'as yet unclassified' }
ArangoDatabase class >> named: aName for: arangoClient [

	
	^(self new)
		dbName: aName;
		client: arangoClient;
		yourself 
]

{ #category : #accessing }
ArangoDatabase >> client [
	^ client
]

{ #category : #accessing }
ArangoDatabase >> client: anObject [
	client := anObject
]

{ #category : #accessing }
ArangoDatabase >> currentCollection [
	^ currentCollection
]

{ #category : #accessing }
ArangoDatabase >> currentCollection: anObject [
	currentCollection := anObject
]

{ #category : #accessing }
ArangoDatabase >> dbName [
	^ dbName
]

{ #category : #accessing }
ArangoDatabase >> dbName: anObject [
	dbName := anObject
]
