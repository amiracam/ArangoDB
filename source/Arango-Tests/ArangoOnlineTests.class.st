"
These tests assumes authentication is not active.
The easiest way I found to ensure that was to modify the arangod.conf file.
Also note that the setup invocation of #createTestDatabase is wrapped in an error handler and that tear down has been commented out.
The purpose is so that test results can also be examined using the Arango web interface.
"
Class {
	#name : #ArangoOnlineTests,
	#superclass : #ArangoTests,
	#category : #'Arango-Tests'
}

{ #category : #accessing }
ArangoOnlineTests >> baseUri [ 
	^ 'http://localhost:8529/'
]

{ #category : #'test-support' }
ArangoOnlineTests >> collectionNameForTest [
	^ 'test-collection'
]

{ #category : #'test-support' }
ArangoOnlineTests >> createExampleDocument [
	arango 
		createDocument: { #foo -> #bar } asDictionary 
		collection: self collectionNameForTest .
]

{ #category : #'test-support' }
ArangoOnlineTests >> createTestCollection [
	arango createCollection: self collectionNameForTest 
]

{ #category : #'test-support' }
ArangoOnlineTests >> removeTestCollection [
	arango removeCollection: self collectionNameForTest 
]

{ #category : #running }
ArangoOnlineTests >> setUp [
	super setUp.
	
	[self createTestDatabase. 
	self createTestCollection] 
		on: ArangoDuplicateNamed 
		do: [:ex | ex description  traceCr  ].
	
]

{ #category : #running }
ArangoOnlineTests >> tearDown [
	super tearDown.
	"self removeTestCollection "
]

{ #category : #tests }
ArangoOnlineTests >> testCallCreateDocument [
	self createExampleDocument 
]

{ #category : #tests }
ArangoOnlineTests >> testSearchExampleDocument [
	| result |
	self createExampleDocument.
	result := arango 
		readOne: self collectionNameForTest
		where: { #foo -> #bar } asDictionary.
		
	self assert: (result at: #foo) equals: #bar
]
