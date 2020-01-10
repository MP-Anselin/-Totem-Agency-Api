FIREBASE_URI = 'https://totem2-f3e2e.firebaseio.com/'.freeze
RESOURCES_PATH = 'app/controllers/api/v1/resources/'.freeze
FIREBASE_PATH_KEY = RESOURCES_PATH + 'totem2-f3e2e-firebase-adminsdk-lfqcp-3e7ed4ba43.json'.freeze
FIREBASE_PROJECT_ID = 'totem2-f3e2e'.freeze
FIREBASE_PRIVATE_KEY = File.open(FIREBASE_PATH_KEY).read.freeze
FIREBASE_API_KEY = 'AIzaSyAriR9Ydg4l0frGiJ2-0SpbE82xxRWVtEM'.freeze

FIREBASE_USER_ACCOUNTS = 'https://identitytoolkit.googleapis.com/v1/accounts:'.freeze

SIGN_UP_ACTION = 'signUp?key='.freeze
SIGN_IN_ACTION = 'signInWithPassword?key='.freeze
LOOK_UP_ACTION = 'lookup?key='.freeze
CODE_PWD_RESET = 'sendOobCode?key='.freeze
PWD_RESET = 'resetPassword?key='.freeze

FIREBASE_SIGN_UP_USER = (FIREBASE_USER_ACCOUNTS + SIGN_UP_ACTION + FIREBASE_API_KEY).freeze
FIREBASE_SING_IN_USER = (FIREBASE_USER_ACCOUNTS + SIGN_IN_ACTION + FIREBASE_API_KEY).freeze
FIREBASE_CODE_PWD_RESET_USER = (FIREBASE_USER_ACCOUNTS + CODE_PWD_RESET + FIREBASE_API_KEY).freeze
FIREBASE_PWD_RESET_USER = (FIREBASE_USER_ACCOUNTS + PWD_RESET + FIREBASE_API_KEY).freeze
FIREBASE_GET_USER_INFO = (FIREBASE_USER_ACCOUNTS + LOOK_UP_ACTION + FIREBASE_API_KEY).freeze
