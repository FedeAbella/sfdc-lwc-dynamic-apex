@isTest
private class LwcInvocableActionDispatcherTest {
    @IsTest
    static void cacheableActionThrowsErrorIfClassIsNull() {
        System.runAs(getRunningUser()) {
            try {
                LwcInvocableActionDispatcher.runCacheableAction(null, null);
                Assert.fail('Method should have failed with a null class name');
            } catch (Exception e) {
                Assert.isInstanceOfType(
                    e,
                    AuraHandledException.class,
                    'Thrown exception should be AuraHandledException'
                );
                Assert.areEqual(
                    buildExpectedExceptionMessage(
                        LwcInvocableActionException.class,
                        LwcInvocableActionDispatcher.CLASS_NAME_REQUIRED_EXCEPTION_MESSAGE
                    ),
                    e.getMessage(),
                    'Exception message does not match expected message'
                );
            }
        }
    }

    @IsTest
    static void nonCacheableActionThrowsErrorIfClassIsNull() {
        System.runAs(getRunningUser()) {
            try {
                LwcInvocableActionDispatcher.runNonCacheableAction(null, null);
                Assert.fail('Method should have failed with a null class name');
            } catch (Exception e) {
                Assert.isInstanceOfType(
                    e,
                    AuraHandledException.class,
                    'Thrown exception should be AuraHandledException'
                );
                Assert.areEqual(
                    buildExpectedExceptionMessage(
                        LwcInvocableActionException.class,
                        LwcInvocableActionDispatcher.CLASS_NAME_REQUIRED_EXCEPTION_MESSAGE
                    ),
                    e.getMessage(),
                    'Exception message does not match expected message'
                );
            }
        }
    }

    @IsTest
    static void cacheableActionThrowsErrorIfClassDoesntExist() {
        String className = 'nonExistantClass.cls';
        System.runAs(getRunningUser()) {
            try {
                LwcInvocableActionDispatcher.runCacheableAction(className, null);
                Assert.fail('Method should have failed with a non existant class name');
            } catch (Exception e) {
                Assert.isInstanceOfType(
                    e,
                    AuraHandledException.class,
                    'Thrown exception should be AuraHandledException'
                );
                Assert.areEqual(
                    buildExpectedExceptionMessage(
                        LwcInvocableActionException.class,
                        String.format(
                            LwcInvocableActionDispatcher.CLASS_DOESNT_EXIST_EXCEPTION_MESSAGE,
                            new List<String>{ className }
                        )
                    ),
                    e.getMessage(),
                    'Exception message does not match expected message'
                );
            }
        }
    }

    @IsTest
    static void nonCacheableActionThrowsErrorIfClassDoesntExist() {
        String className = 'nonExistantClass.cls';
        System.runAs(getRunningUser()) {
            try {
                LwcInvocableActionDispatcher.runNonCacheableAction(className, null);
                Assert.fail('Method should have failed with a non existant class name');
            } catch (Exception e) {
                Assert.isInstanceOfType(
                    e,
                    AuraHandledException.class,
                    'Thrown exception should be AuraHandledException'
                );
                Assert.areEqual(
                    buildExpectedExceptionMessage(
                        LwcInvocableActionException.class,
                        String.format(
                            LwcInvocableActionDispatcher.CLASS_DOESNT_EXIST_EXCEPTION_MESSAGE,
                            new List<String>{ className }
                        )
                    ),
                    e.getMessage(),
                    'Exception message does not match expected message'
                );
            }
        }
    }

    @IsTest
    static void cacheableActionThrowsErrorIfClassDoesntImplementInterface() {
        String className = 'LwcInvocableActionDispatcher'; // The dispatcher doesn't implement the interface
        System.runAs(getRunningUser()) {
            try {
                LwcInvocableActionDispatcher.runCacheableAction(className, null);
                Assert.fail(
                    'Method should have failed when passed a class that doesnt implement ILwcInvocableAction interface'
                );
            } catch (Exception e) {
                Assert.isInstanceOfType(
                    e,
                    AuraHandledException.class,
                    'Thrown exception should be AuraHandledException'
                );
                Assert.areEqual(
                    buildExpectedExceptionMessage(
                        LwcInvocableActionException.class,
                        String.format(
                            LwcInvocableActionDispatcher.CLASS_ISNT_ACTION_EXCEPTION_MESSAGE,
                            new List<String>{ className }
                        )
                    ),
                    e.getMessage(),
                    'Exception message does not match expected message'
                );
            }
        }
    }

    @IsTest
    static void nonCacheableActionThrowsErrorIfClassDoesntImplementInterface() {
        String className = 'LwcInvocableActionDispatcher'; // The dispatcher doesn't implement the interface
        System.runAs(getRunningUser()) {
            try {
                LwcInvocableActionDispatcher.runNonCacheableAction(className, null);
                Assert.fail(
                    'Method should have failed when passed a class that doesnt implement ILwcInvocableAction interface'
                );
            } catch (Exception e) {
                Assert.isInstanceOfType(
                    e,
                    AuraHandledException.class,
                    'Thrown exception should be AuraHandledException'
                );
                Assert.areEqual(
                    buildExpectedExceptionMessage(
                        LwcInvocableActionException.class,
                        String.format(
                            LwcInvocableActionDispatcher.CLASS_ISNT_ACTION_EXCEPTION_MESSAGE,
                            new List<String>{ className }
                        )
                    ),
                    e.getMessage(),
                    'Exception message does not match expected message'
                );
            }
        }
    }

    @IsTest
    static void cacheableActionExposesInnerExceptionDetailsIfRunMethodThrowsException() {
        String className = 'ILwcInvocableActionMock';
        ILwcInvocableActionMock.result = ILwcInvocableActionMock.RUN_RESULT.ERROR;
        System.runAs(getRunningUser()) {
            try {
                LwcInvocableActionDispatcher.runCacheableAction(className, null);
                Assert.fail('Method should have failed when run() method fails');
            } catch (Exception e) {
                Assert.isInstanceOfType(
                    e,
                    AuraHandledException.class,
                    'Thrown exception should be AuraHandledException'
                );
                Assert.areEqual(
                    buildExpectedExceptionMessage(
                        LwcInvocableActionException.class,
                        ILwcInvocableActionMock.RUN_ERROR_EXCEPTION_MESSAGE
                    ),
                    e.getMessage(),
                    'Exception message does not match expected message'
                );
            }
        }
    }

    @IsTest
    static void nonCacheableActionExposesInnerExceptionDetailsIfRunMethodThrowsException() {
        String className = 'ILwcInvocableActionMock';
        ILwcInvocableActionMock.result = ILwcInvocableActionMock.RUN_RESULT.ERROR;
        System.runAs(getRunningUser()) {
            try {
                LwcInvocableActionDispatcher.runNonCacheableAction(className, null);
                Assert.fail('Method should have failed when run() method fails');
            } catch (Exception e) {
                Assert.isInstanceOfType(
                    e,
                    AuraHandledException.class,
                    'Thrown exception should be AuraHandledException'
                );
                Assert.areEqual(
                    buildExpectedExceptionMessage(
                        LwcInvocableActionException.class,
                        ILwcInvocableActionMock.RUN_ERROR_EXCEPTION_MESSAGE
                    ),
                    e.getMessage(),
                    'Exception message does not match expected message'
                );
            }
        }
    }

    @IsTest
    static void cacheableActionReturnsRunMethodOutputWhenMethodSucceedsAndRequestIsNull() {
        String className = 'ILwcInvocableActionMock';
        ILwcInvocableActionMock.result = ILwcInvocableActionMock.RUN_RESULT.SUCCESS;
        System.runAs(getRunningUser()) {
            LwcInvocableActionResponse response = LwcInvocableActionDispatcher.runCacheableAction(className, null);
            Assert.isNotNull(response, 'Running the action should have returned a non-null object');
            Assert.isNotNull(response.result, 'Result property of response should not be null');
            Assert.isTrue(
                response.result.containsKey('input'),
                'Response result property should contain the input key created in run() method'
            );
            Assert.isTrue(
                response.result.containsKey('options'),
                'Response result property should contain the options key created in run() method'
            );
            Assert.isNull(response.result.get('input'), 'Response should have null input created in run() method');
            Assert.isNull(response.result.get('options'), 'Response should have null options created in run() method');
        }
    }

    @IsTest
    static void nonCacheableActionReturnsRunMethodOutputWhenMethodSucceedsAndRequestIsNull() {
        String className = 'ILwcInvocableActionMock';
        ILwcInvocableActionMock.result = ILwcInvocableActionMock.RUN_RESULT.SUCCESS;
        System.runAs(getRunningUser()) {
            LwcInvocableActionResponse response = LwcInvocableActionDispatcher.runNonCacheableAction(className, null);
            Assert.isNotNull(response, 'Running the action should have returned a non-null object');
            Assert.isNotNull(response.result, 'Result property of response should not be null');
            Assert.isTrue(
                response.result.containsKey('input'),
                'Response result property should contain the input key created in run() method'
            );
            Assert.isTrue(
                response.result.containsKey('options'),
                'Response result property should contain the options key created in run() method'
            );
            Assert.isNull(response.result.get('input'), 'Response should have null input created in run() method');
            Assert.isNull(response.result.get('options'), 'Response should have null options created in run() method');
        }
    }

    @IsTest
    static void cacheableActionReturnsRunMethodOutputWhenMethodSucceedsAndRequestIsNotNull() {
        String className = 'ILwcInvocableActionMock';
        ILwcInvocableActionMock.result = ILwcInvocableActionMock.RUN_RESULT.SUCCESS;
        LwcInvocableActionRequest request = new LwcInvocableActionRequest();
        request.input = new Map<String, Object>{ 'input1' => 'value 1', 'input2' => true };
        request.options = new Map<String, Object>{
            'option1' => 5,
            'option2' => new List<String>{ 'element1', 'element2' }
        };
        System.runAs(getRunningUser()) {
            LwcInvocableActionResponse response = LwcInvocableActionDispatcher.runCacheableAction(className, request);
            Assert.isNotNull(response, 'Running the action should have returned a non-null object');
            Assert.isNotNull(response.result, 'Result property of response should not be null');
            Assert.isTrue(
                response.result.containsKey('input'),
                'Response result property should contain the input key created in run() method'
            );
            Assert.isTrue(
                response.result.containsKey('options'),
                'Response result property should contain the options key created in run() method'
            );
            Assert.areEqual(
                request.input,
                response.result.get('input'),
                'Response should have the same input object put there in run() method'
            );
            Assert.areEqual(
                request.options,
                response.result.get('options'),
                'Response should have the same options object put there in run() method'
            );
        }
    }

    @IsTest
    static void nonCacheableActionReturnsRunMethodOutputWhenMethodSucceedsAndRequestIsNotNull() {
        String className = 'ILwcInvocableActionMock';
        ILwcInvocableActionMock.result = ILwcInvocableActionMock.RUN_RESULT.SUCCESS;
        LwcInvocableActionRequest request = new LwcInvocableActionRequest();
        request.input = new Map<String, Object>{ 'input1' => 'value 1', 'input2' => true };
        request.options = new Map<String, Object>{
            'option1' => 5,
            'option2' => new List<String>{ 'element1', 'element2' }
        };
        System.runAs(getRunningUser()) {
            LwcInvocableActionResponse response = LwcInvocableActionDispatcher.runNonCacheableAction(
                className,
                request
            );
            Assert.isNotNull(response, 'Running the action should have returned a non-null object');
            Assert.isNotNull(response.result, 'Result property of response should not be null');
            Assert.isTrue(
                response.result.containsKey('input'),
                'Response result property should contain the input key created in run() method'
            );
            Assert.isTrue(
                response.result.containsKey('options'),
                'Response result property should contain the options key created in run() method'
            );
            Assert.areEqual(
                request.input,
                response.result.get('input'),
                'Response should have the same input object put there in run() method'
            );
            Assert.areEqual(
                request.options,
                response.result.get('options'),
                'Response should have the same options object put there in run() method'
            );
        }
    }

    private static User getRunningUser() {
        return new User(Id = UserInfo.getUserId());
    }

    private static String buildExpectedExceptionMessage(System.Type exceptionClass, String exceptionMessage) {
        return String.format('{0}: {1}', new List<String>{ exceptionClass.getName(), exceptionMessage });
    }
}
