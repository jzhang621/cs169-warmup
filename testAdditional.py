import unittest
import os
import testLib

"""
class TestAddUser(testLib.RestTestCase):

    def assertResponse(self, respData, count=1, errCode = testLib.RestTestCase.SUCCESS):
        expected = {'errCode': errCode}
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user': 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count=1)
"""


class TestAddLogin(testLib.RestTestCase):
    """Test adding user then logging user in"""

    def assertResponse(self, respData, count=2, errCode=testLib.RestTestCase.SUCCESS):
        expected = {'errCode': errCode}
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testAddLogin(self):
        self.makeRequest("/users/add", method="POST", data={'user': 'user1', 'password': 'password'})
        respData = self.makeRequest("/users/login", method="POST", data = {'user': 'user1', 'password': 'password'})
        self.assertResponse(respData)


class TestLoginBad(testLib.RestTestCase):

    def assertResponse(self, respData, count=None, errCode=testLib.RestTestCase.ERR_BAD_CREDENTIALS):
        expected = {'errCode': errCode}
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testLoginBad(self):
        respData = self.makeRequest("/users/login", method="POST", data={'user': 'user1', 'password': 'password'})
        self.assertResponse(respData)


class TestAddSameUser(testLib.RestTestCase):

    def assertResponse(self, respData, count=None, errCode=testLib.RestTestCase.ERR_USER_EXISTS):
        expected = {'errCode': errCode}
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testAddSameUser(self):
        self.makeRequest("/users/add", method="POST", data={'user': 'user1', 'password': 'password'})
        respData = self.makeRequest("/users/add", method="POST", data={'user': 'user1', 'password': 'pass'})
        self.assertResponse(respData)


class TestAddBlankUser(testLib.RestTestCase):

    def assertResponse(self, respData, count=None, errCode=testLib.RestTestCase.ERR_BAD_USERNAME):
        expected = {'errCode': errCode}
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testAddBlankUser(self):
        respData = self.makeRequest("/users/add", method="POST", data={'user': '', 'password': 'password'})
        self.assertResponse(respData)


class TestLongUsername(testLib.RestTestCase):

    def assertResponse(self, respData, count=None, errCode=testLib.RestTestCase.ERR_BAD_USERNAME):
        expected = {'errCode': errCode}
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testLongUsername(self):
        respData = self.makeRequest("/users/add", method="POST", data={'user': 'a'*129, 'password': 'password'})
        self.assertResponse(respData)


class TestLongPassword(testLib.RestTestCase):

    def assertResponse(self, respData, count=None, errCode=testLib.RestTestCase.ERR_BAD_PASSWORD):
        expected = {'errCode': errCode}
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testLongPassword(self):
        respData = self.makeRequest("/users/add", method="POST", data={'user': 'user1', 'password': 'p'*129})
        self.assertResponse(respData)


class TestResetFixture(testLib.RestTestCase):

    def assertResponse(self, respData, count=None, errCode=testLib.RestTestCase.ERR_BAD_CREDENTIALS):
        expected = {'errCode': errCode}
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testLongUsername(self):
        self.makeRequest("/users/add", method="POST", data={'user': 'user1', 'password': 'password'})
        self.makeRequest("/TESTAPI/resetFixture", method="POST")
        respData = self.makeRequest("/users/login", method="POST", data={'user': 'user1', 'password': 'password'})
        self.assertResponse(respData)


class TestEmptyPassword(testLib.RestTestCase):

    def assertResponse(self, respData, count=1, errCode=testLib.RestTestCase.SUCCESS):
        expected = {'errCode': errCode}
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testLongUsername(self):
        respData = self.makeRequest("/users/add", method="POST", data={'user': 'user1', 'password': ''})
        self.assertResponse(respData)