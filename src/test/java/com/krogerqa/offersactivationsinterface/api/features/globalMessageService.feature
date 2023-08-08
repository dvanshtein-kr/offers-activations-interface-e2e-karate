Feature: Global Message service endpoint API Validation

  Background:
    * configure ssl = true
    * def Oauth = call read('../../Oauth.feature')
    * def var1 = ""
    * def date = Java.type('com.krogerqa.globalMessage.testUtil')

  @smoke @regression @apiCreateGlobalMessageTypeInfo @qmetry @globalMessage
  Scenario: Verify  Global Message create
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
#    * header Authorization = Oauth.BearerToken
    * def startDate = date.getDateWithTimestamp(0,5,02,30)
    * def endDate = date.getDateWithTimestamp(1,6,02,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/postCreateGlobalMessage.json')
    * set pCGM.appId = appName
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 200

  @smoke @regression @apiCreateGlobalMessageMissingLinkText @globalMessage
  Scenario: 2 Verify  Global Message create when linkText is missing
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,6,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/postCreateGlobalMessage.json')
    * set pCGM.appId = appName
    * remove pCGM.linkText
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 200

  @smoke @regression @apiCreateGlobalMessageTypeError @globalMessage
  Scenario: 3 Verify  Global Message create with messagetype as Error
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,6,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 200

  @smoke @regression @apiCreateGlobalMessageTypeWarning&MissingLink @globalMessage
  Scenario: 3 Verify  Global Message create with messagetype as Warning and missing link
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
      Given url ngppGMSAppRegUrl
      And path 'api/v1/globalMessage/'
      And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,4,00,04)
    * def endDate = date.getDateWithTimestamp(0,6,00,35)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * remove pCGM.link
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 200

  @smoke @regression @apiCreateScheduledGlobalMessageTypeWarning&MissingLink @globalMessage
  Scenario: 3 Verify  Global Message create with messagetype as Warning and missing link
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(1,8,00,10)
    * def endDate = date.getDateWithTimestamp(1,9,00,35)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * remove pCGM.link
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 200

  @smoke @regression @apiCreateGlobalMessageBody>200 @globalMessage
  Scenario: 4 Verify to check the length of the body >200
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,6,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSBody201.json')
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.body == 'body must be between 1 and 200 characters long'

  @smoke @regression @apiCreateGlobalMessageHeader>100 @globalMessage
  Scenario: 5 Verify to check the length of the header >100
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,6,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSHeader101.json')
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.headLine == 'headLine must be between 1 and 100 characters long'


  @smoke @regression @apiCreateGlobalMessageMissingMessageType @globalMessage
  Scenario: 6 Verify to check error message when message type is missing
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,6,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * remove pCGM.messageType
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.messageType == 'Message type must be provided'

  @smoke @regression @apiCreateGlobalMessageEndDate<StartDate @globalMessage
  Scenario: 7 Verify to check error message when EndDate<StartDate
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,5,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.errors.reason == 'End Date cannot be before Start Date'

  @smoke @regression @apiCreateGlobalMessageMissingStartDate @globalMessage
  Scenario: 8 Verify the error message when missing start date
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,5,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * remove pCGM.startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.startDate == 'Start Date must be provided'

  @smoke @regression @apiCreateGlobalMessageMissingEndDate @globalMessage
  Scenario: 9 Verify the error message when missing End date
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,5,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * remove pCGM.endDate
    * replace pCGM.{{startDate}} = startDate
    When request pCGM
    When method post
    Then status 200

  @smoke @regression @apiCreateGlobalMessageMissingHeadline @globalMessage
  Scenario: 10 Verify the error message when missing headline
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,5,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * remove pCGM.headLine
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.headLine == 'headLine must be provided'

  @smoke @regression @apiCreateGlobalMessageStartDate=EndDate @globalMessage
  Scenario: 11 Verify the error message when StartDate=EndDate
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,6,02,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.errors.reason == 'End Date cannot be before Start Date'

  @smoke @regression @apiCreateGlobalMessageMissingRole @globalMessage
  Scenario: 12 Verify the error message when role is blank
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,6,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * remove pCGM.roles
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.errors.reason == 'Cannot create a global message without roles. Please select at least one Role'

  @smoke @regression @apiCreateGlobalMessageLink>100 @globalMessage
  Scenario: 13 Verify the error message when link>100
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,6,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeLink101.json')
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.link == 'link must be between 0 and 100 characters long'

  @smoke @regression @apiCreateGlobalMessageLinkText>100 @globalMessage
  Scenario: 14 Verify the error message when linkText>100
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(0,6,05,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeLinkText101.json')
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $response.linkText == 'linkText must be between 0 and 100 characters long'

  @smoke @regression @apiCreateGlobalMessage @globalMessage
  Scenario: 3 Verify  Global Message created
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,5,00,10)
    * def endDate = date.getDateWithTimestamp(0,6,00,35)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 200

#GET Call by Message ID
  @smoke @regression @getGlobalMessageById @globalMessage
  Scenario: 1 Verify get Global Message by Id
    * def GMSId = call read('globalMessageService.feature@apiCreateGlobalMessage')
    * def globalmessageId = GMSId.response.data[0].id
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'+ globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 200
    And match $.code.explanation == 'Success'

  # updating below test case as local as it is taking more time to wait for running message in github server
  @local
   Scenario: 2 Verify get Global Message by Id Running
    * def GMSId = call read('globalMessageService.feature@apiCreateGlobalMessageTypeWarning&MissingLink')
    * def globalmessageId = GMSId.response.data[0].id
    * def appName = GMSId.response.data[0].appId
   # * listen 40000
    * configure retry = { count: 5, interval: 20000 }
    And retry until response.data[0].messageStatus == 'Running'

    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 200
    * def resp = response.data[0].messageStatus
    And match $.code.explanation == 'Success'
    And match $.data[0].id == globalmessageId
    And match $.data[0].messageStatus == 'Running'

  @smoke @regression @getGlobalMessageByIdStardateMatch @globalMessage
  Scenario: 3 Verify get Global Message StartdateMatch
    * def GMSId = call read('globalMessageService.feature@apiCreateGlobalMessageTypeWarning&MissingLink')
    * def StartDate = GMSId.response.data[0].startDate
    * def globalmessageId = GMSId.response.data[0].id
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 200
    And match $.code.explanation == 'Success'
    And match $.data[0].startDate == StartDate

  @smoke @regression @getGlobalMessageByIdEnterDeletedID @globalMessage
  Scenario: 4 Verify get Global Message EnterDeletedID
    * def GMSId = call read('globalMessageService.feature@apiCreateGlobalMessageTypeInfo')
    * def globalmessageId = GMSId.response.data[0].id
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method delete
    Then status 200
    And match $.code.explanation == 'Success'
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 400
    And match response.errors.reason == 'The Message is Archived'


  @smoke @regression @deleteGMS @globalMessage
  Scenario: 1 Verify delete archived message
    * def GMSId = call read('globalMessageService.feature@apiCreateGlobalMessageTypeInfo')
    * def globalmessageId = GMSId.response.data[0].id
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method delete
    Then status 200
    And match $.code.explanation == 'Success'
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method delete
    Then status 400
    And match $response.errors.reason == 'Message has been already deleted'

# updating below test case as local as it is taking more time to wait for running message in github server
  @local @E2E
  Scenario: 3 Verify to delete running message
    * def GMSId = call read('globalMessageService.feature@apiCreateGlobalMessageTypeWarning&MissingLink')
    * def globalmessageId = GMSId.response.data[0].id
   # * listen 40000
    * configure retry = { count: 5, interval: 20000 }
    And retry until response.data[0].messageStatus == 'Running'
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 200
    And match $.data[0].messageStatus == 'Running'
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method delete
    Then status 200
    And match $.code.explanation == 'Success'


  @smoke @regression @getGlobalMessageDeletingScheduleMessage @globalMessage
  Scenario: 4 Verify to delete Schedule message
    * def GMSId = call read('globalMessageService.feature@apiCreateScheduledGlobalMessageTypeWarning&MissingLink')
    * def globalmessageId = GMSId.response.data[0].id
    * def appName = GMSId.response.data[0].appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method delete
    Then status 200
    And match $.code.explanation == 'Success'

  @smoke @regression @apiCreateGlobalMessage @globalMessage
  Scenario: Verify  Global Message created
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,5,00,10)
    * def endDate = date.getDateWithTimestamp(0,6,00,35)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 200

  @smoke @regression @apiCreateGlobalMessageAppIdAlreadyExists @qmetry @globalMessage
  Scenario: Verify AppId already already exists message
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,6,02,30)
    * def endDate = date.getDateWithTimestamp(1,6,02,30)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/postCreateGlobalMessage.json')
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 400
    And match $.errors.reason == 'Application does not exist with AppId'

   #-------getRunningMessageByAPPID End point-----------
  # updating below test case as local as it is taking more time to wait for running message in github server
  @local @E2E
  Scenario:  Verify get running global message By Id
    * def GMSId = call read('globalMessageService.feature@apiCreateGlobalMessageTypeWarning&MissingLink')
   # * listen 40000
    * configure retry = { count: 5, interval: 20000 }
    And retry until response.data[0].messageStatus == 'Running'
    * def globalmessageId = GMSId.response.data[0].id
    * def appName = GMSId.response.data[0].appId.toLowerCase()
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/getRunningMessages/'+ appName.toLowerCase()
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 200
    And match $.code.explanation == 'Success'
    And match $.data[0].messageStatus == 'Running'
    And match $.data.size() != 0


  @smoke @regression @E2E @getRunningMessagesByAppId @globalMessage
  Scenario: 4 Verify that Scheduled message should not display for getRunningMessagesAPIByAppId
    * def GMSId = call read('globalMessageService.feature@apiCreateScheduledGlobalMessageTypeWarning&MissingLink')
    * def globalmessageId = GMSId.response.data[0].id
    * def appName = GMSId.response.data[0].appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/getRunningMessages/'+ appName
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 200
    And match $.code.explanation == 'Success'
    And match $.data.size() == 0

  @smoke @regression @E2E @getGlobalMessageByAppIdEnterDeletedID @globalMessage
  Scenario: Verify that deleted global message should not display for getRunningMessagesAPIByAppId
    * def GMSId = call read('globalMessageService.feature@apiCreateGlobalMessageTypeInfo')
    * def globalmessageId = GMSId.response.data[0].id
    * def appName = GMSId.response.data[0].appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method delete
    Then status 200
    And match $.code.explanation == 'Success'
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/getRunningMessages/'+ appName
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 200
    And match $.code.explanation == 'Success'
    And match $.data.size() == 0

   # updating below test case as local as it is taking more time to wait for running message in github server
  @local @E2E
  Scenario: 3 Verify that expired message is created and expired global message should not display for getRunningMessagesAPIByAppId
    * def resp = call read('classpath:com/krogerqa/globalMessage/api/features/globalMessageAppRegistrationService.feature@apiCreateApplicationRegistration')
    * def appName = resp.response.data.appId
    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/'
    And header Content-Type = 'application/json; charset=utf-8'
    * def startDate = date.getDateWithTimestamp(0,4,00,05)
    * def endDate = date.getDateWithTimestamp(0,4,00,07)
    * def pCGM = read('classpath:com/krogerqa/globalMessage/api/data/GMS/postCreateGMSTypeError.json')
    * set pCGM.appId = appName
    * remove pCGM.link
    * replace pCGM.{{startDate}} = startDate
    * replace pCGM.{{endDate}} = endDate
    When request pCGM
    When method post
    Then status 200
    * configure retry = { count: 5, interval: 20000 }
    And retry until response.data[0].messageStatus == 'Expired'
   # * listen 40000

    * def globalmessageId = response.data[0].id

    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/' + globalmessageId
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 200
    And match $.data[0].messageStatus == 'Expired'

    Given url ngppGMSAppRegUrl
    And path 'api/v1/globalMessage/getRunningMessages/'+ appName
    And header Content-Type = 'application/json; charset=utf-8'
    When method get
    Then status 200
    And match $.code.explanation == 'Success'
    And match $.data.size() == 0
