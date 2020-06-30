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
	self halt. 
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

{ #category : #'tests-AQL' }
ArangoOnlineTests >> testBasicCreateCursor [
	| rs query |
	
	
	query := 'FOR p IN collection1 LIMIT 2 RETURN p'.
	rs :=
	 arango 
			createDatabaseIfDoesntExist: 'Database1';
			database: 'Database1';
			createCollectionIfDoesntExist: 'collection1';
			collection: 'collection1';
			createCursor: query.
			
	"empty collection , empty result, but parsing passes"	
	
	self assert: (rs result isEmpty).
	self assert: ((rs at: 'error') not)
]

{ #category : #tests }
ArangoOnlineTests >> testCallCreateDocument [
	self createExampleDocument 
]

{ #category : #tests }
ArangoOnlineTests >> testCreateCollection1 [
	self halt.
	arango database: 'pharo-tests'.
	arango createCollectionIfDoesntExist: 'Collection1'.
	self flag: 'do a collection list and check in included'
]

{ #category : #tests }
ArangoOnlineTests >> testCreateDocument1 [
		
		arango database:'pharo-tests'.
		arango collection1 createDocument: { #foo -> #bar } asDictionary 
		
]

{ #category : #'tests-AQL' }
ArangoOnlineTests >> testFindByID [
	|docHandle response arangoResponse |
	
	self flag: 'set database and collection1 transparently and implictly'.
	 arango 
			createDatabaseIfDoesntExist: 'Database1';
			database: 'Database1';
			createCollectionIfDoesntExist: 'collection1';
			collection: 'collection1'.
			
	docHandle := arango createDocument: { #foo -> #bar } asDictionary.
	self halt. 
	response := arango findById: docHandle handleString.
	self halt. 
	
	arangoResponse := NeoJSONReader fromString: (NeoJSONWriter toString: response)  as: ArangoResponse .	
	"empty collection , empty result, but parsing passes"	
	self flag: 'provide a #dataAs: '.
 	self assert: (arangoResponse data at: 'foo') equals: 'bar'
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
