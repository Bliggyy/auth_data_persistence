# basecodeflutter

Base code for my flutter projects.

Auth With Data Persistence

This is a simple app that allows for signing in using email and google and allows data persistence such that the user will not be logged out if he or she exists the app

Also I added some error alert messages if there are any

Note:
From the latest changes a couple of things caught me:

1. Had to change the sdk version to 19 
2. Had to add multiDexEnabled in the default config as well as its dependency
3. In logging in using google or email, a freshToken was not generated (using debug showed empty string) so I had to comment it out at the moment, just in the LocalStorageService portion
4. I didnt use the databse query to check if email exists since I wanted to try out the FirebaseAuthException
5. I had to change the function from signInWithEmailAndPassword to createUserWithEmailAndPassword in createUser() because it returned null to userCredential. I have no idea why it worked for you sir 
