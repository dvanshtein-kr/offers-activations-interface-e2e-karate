Feature: Global Message service Application Registration endpoint API Validation

  Background:
    * configure ssl = true
    * def var1 = ""
    * def utils = Java.type('com.krogerqa.globalMessage.testUtil')

  @smoke @regression @apiCreateApplicationRegistration @apiGMSAppRegistration
  Scenario: Verify  Application registration
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def spmId = utils.randomIntegerGenerator()
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json')
    * set pCGM.appId = pCGM.appId + '-' + spmId
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 200

  @regression @apiCreateAppRegistrationWhenspmIdIsNull @apiGMSAppRegistration
  Scenario: Verify  Application registration when spmId is null
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def spmId = ""
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json',)
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 400
    And match $response.spmId == 'SPM_ID must be provided'

  @regression @apiCreateAppRegistrationWhenAppIdIsNull @apiGMSAppRegistration
  Scenario: Verify Application registration when appId is not present
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def spmId = utils.randomIntegerGenerator()
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json',)
    * set pCGM.appId = ''
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 400
    And match $response.appId == 'Application ID must be provided'

  @regression @apiCreateAppRegistrationWithoutRole @apiGMSAppRegistration
  Scenario: Verify  Application registration when role is not present
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def spmId = utils.randomIntegerGenerator()
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json',)
    * set pCGM.roles = null
    * set pCGM.appId = pCGM.appId + '-' + spmId
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 400
    And match $response.errors.reason == 'Cannot create an Application without roles. Please select at least one Role'

  @regression @apiCreateAppRegistrationWithoutDescription @apiGMSAppRegistration
  Scenario: Verify  Application registration when application description  is not present
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    #* header Authorization = Oauth.bearerToken
    * def spmId = utils.randomIntegerGenerator()
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json',)
    * set pCGM.desc = null
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 400
    And match $response.desc == 'Application Description must be provided'

  @regression @apiCreateAppRegistrationWithoutDescription @apiGMSAppRegistration
  Scenario: Verify  Application registration when serviceNowId and poc are not present
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    #* header Authorization = Oauth.bearerToken
    * def spmId = utils.randomIntegerGenerator()
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json',)
    * set pCGM.appId = pCGM.appId + '-' + spmId
    * set pCGM.serviceNowId = null
    * set pCGM.poc = null
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 200

  Scenario: Verify  Application registration when appId is greater than 15 char
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def spmId = utils.randomIntegerGenerator()
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json',)
    * set pCGM.appId = "TestAppIdLength123"
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 400
    And match $response.errors.reason == "App Name (including 'A-') must be between 1 and 15 characters long"

  @regression @apiCreateAppRegistrationWithoutDescription @apiGMSAppRegistration
  Scenario: Verify  Application registration when serviceNowId is greater than 20 char
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def spmId = utils.randomIntegerGenerator()
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json',)
    * set pCGM.serviceNowId = "TestServiceNowIdLength"
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 400
    And match $response.serviceNowId == 'ServiceNowID must be between 0 and 20 characters long'

  @regression @apiCreateAppRegistrationWithoutDescription @apiGMSAppRegistration
  Scenario: Verify  Application registration when poc is greater than 100 char
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def spmId = utils.randomIntegerGenerator()
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json',)
    * set pCGM.poc = "Wikipedia has been praised for its enablement of the democratization of knowledge, extent of coverage"
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 400
    And match $response.poc == 'POC must be between 0 and 100 characters long'

  @regression @apiCreateAppRegistrationWithoutDescription @apiGMSAppRegistration
  Scenario: Verify  Application registration when application description is greater than 500 char
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def spmId = utils.randomIntegerGenerator()
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterApplication.json',)
    * set pCGM.desc = "Wikipedia has been praised for its enablement of the democratization of knowledge, extent of coverage. Software testing is the act of examining the artifacts and the behavior of the software under test by validation and verification. Software testing can also provide an objective, independent view of the software to allow the business to appreciate and understand the risks of software implementation. Test techniques include, but are not necessarily limited to analyzing the product requirements fo"
    * replace pCGM.{{spmId}} = spmId
    When request pCGM
    When method post
    Then status 400
    And match $response.desc == 'Application Description must be between 1 and 500 characters long'

#    ------------------------------------ EDIT Application Registration ----------------------------------------

  @smoke @regression @apiGMSEditApplicationDescription @apiGMSAppRegistration
  Scenario: Verify to edit Application description
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.desc = 'App Description Changed'
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 200

  @smoke @regression @apiGMSEditPOC @apiGMSAppRegistration
  Scenario: Verify to edit POC
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.poc = 'SOAUser'
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 200

  @smoke @regression @apiGMSEditServicenowID @apiGMSAppRegistration
  Scenario: Verify to edit ServicenowID
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.serviceNowId = 'INCSOA4582'
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 200

  @smoke @regression @apiGMSEditRoles @apiGMSAppRegistration
  Scenario: Verify to edit change Roles
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplicationRoles.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 200

  @smoke @regression @apiGMSEditServicenowID<=20 @apiGMSAppRegistration
  Scenario: Verify the response when ServiceNowID <=20
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.serviceNowId = 'SOAINC4582SOAINC4582'
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 200

  @smoke @regression @apiGMSEditServicenowID>20 @apiGMSAppRegistration
  Scenario: Verify the response when ServiceNowID >20
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.serviceNowId = 'SOAINC4582SOAINC4582A'
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 400
    And match response.serviceNowId == 'ServiceNowID must be between 0 and 20 characters long'


  @smoke @regression @apiGMSEditApplicationID @apiGMSAppRegistration
  Scenario: Verify that ApplicationId should not be able to edit
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 400
    And match $response.errors.reason == 'Application does not exist with AppId'

  @smoke @regression @apiGMSEditPOC>100 @apiGMSAppRegistration
  Scenario: Verify the response when POC >100
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.poc = 'SOAUser123SOAUser123SOAUser123SOAUser123SOAUser123SOAUser123SOAUser123SOAUser123SOAUser123SOAUser123A'
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 400
    And match response.poc == 'POC must be between 0 and 100 characters long'


  @smoke @regression @apiGMSEditAppDescSpace @apiGMSAppRegistration
  Scenario: Verify that when App desc contains only space
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.desc = ' '
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 400
    And match response.desc == 'Application Description must be provided'


  @smoke @regression @apiGMSEditAppIDRemove @apiGMSAppRegistration
  Scenario: Verify when ApplicationID is removed
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * remove pCGM.appId
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 400
    And match response.appId == 'Application ID must be provided'


  @smoke @regression @apiGMSEditSPMIDRemove @apiGMSAppRegistration
  Scenario: Verify when SPMID is removed
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * remove pCGM.spmId
    When request pCGM
    When method put
    Then status 400
    And match response.spmId == 'SPM_ID must be provided'

  @smoke @regression @apiGMSEditServicenowIDRemoved @apiGMSAppRegistration
  Scenario: Verify the response when ServiceNowID Removed
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * remove pCGM.serviceNowId
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 200

  @smoke @regression @apiGMSEditServicenowIDSpace @apiGMSAppRegistration
  Scenario: Verify the response when ServiceNowID Space
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.serviceNowId = ' '
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 200


  @smoke @regression @apiGMSEditPOCRemoved @apiGMSAppRegistration
  Scenario: Verify the POC is removed
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * remove pCGM.poc
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 200

  @smoke @regression @apiGMSEditRolesRemoved @apiGMSAppRegistration
  Scenario: Verify the Roles is removed
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * remove pCGM.roles
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 400
    And match $response.errors.reason == 'Cannot create an Application without roles. Please select at least one Role'

  @smoke @regression @apiGMSEditAppDescBlank @apiGMSAppRegistration
  Scenario: Verify the AppDesc is Blank
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.desc = ''
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 400
    And match response.desc == 'Application Description must be provided'

  @smoke @regression @apiGMSEditAppDesc>500 @apiGMSAppRegistration
  Scenario: Verify the AppDesc>500
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditAppDesc501.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * replace pCGM.{{spmId}} = spmid
    When request pCGM
    When method put
    Then status 400
    And match response.desc == 'Application Description must be between 1 and 500 characters long'

  @smoke @regression @apiGMSEditSPMID @apiGMSAppRegistration
  Scenario: Verify that user should not be able to edit the SPMID
    * def resp = call read('globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def AppID = resp.response.data.id
    * def spmid = resp.response.data.spmId
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl + '/api/v1/application'
    And header Content-Type = 'application/json; charset=utf-8'
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postRegisterEditApplication.json')
    * set pCGM.id = AppID
    * set pCGM.appId = appName
    * set pCGM.spmId = '8585'
    When request pCGM
    When method put
    Then status 400
    And match $response.errors.reason == 'SPM ID is non editable'