# IITK Mail Client

## Steps to run
1. Clone the Git Repo
2. Open it in Android Studio
3. Select the Project View to open it
4. Configure the run button to run app.dart
5. In app.dart, at the end of the file we find a line 
```
home: const mailview(title: 'IITK Mail Client'),
```
   In this line, change the "mailview" to "homepage" to view homepage ( i.e. the list email view ) and to "loginpage" to view the loginpage.

6. For the Virtual device, use Google Pixel 6a, UpsideDownCake for API level 34 and Android 14.

Currently, I have built it for Google Pixel 6a ( my phone ). I need to do it for other devices and build connections for login redirect and state change 😅.
