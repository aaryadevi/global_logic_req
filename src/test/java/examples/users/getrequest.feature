Feature: to write scenario for testing  given url 

  Background:
    * url ' https://httpbin.org/'


  Scenario: get all status codes
    Given path '#/Status_codes'
    When method get
    Then status 200

    Scenario: to post request for success request
    Given path '#/Status_codes/post_status__codes'
    And request {code:'201',Description:'Created'}
    When method post
    Then status 200
    And match $ contains {code:"201"}

  Scenario: get all status codes with delayed response
    Given path '#/Status_codes'
    When method get
    *def responseDelay = 6000
    Then status 200
    And match $ contains{status code:"GET"}
    
  Scenario: to check authorisation
    Given path '#/Auth'
    * path 'token'
    * form field grant_type = 'password'
    * form field client_id = 'user'
    * form field client_secret = 'password'
    * form field username = 'userN'
    * form field password = 'userPass'
    When method post
    Then status 200
    * def accessToken= response.access_token
    * path 'get_bearer'
    * header Authorization= 'Bearer'+accessToken
    When method get
    Then status 200

    Scenario: where no status code is present
    Given path '#/Status_codes'
    When method get
    Then status 203
