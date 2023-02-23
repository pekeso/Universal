# Developer environment

Thid document descibe how to set up the developer enviroment.

After you setup the project you will be able to:

- Build the extention's package
- Update the translations
- Run the tests

## Visual Studio Code

Create the file .vscode/settings.json and set the requested cmake options.  
You can take the following example and modify the paths.

```json
{
    "cmake.configureSettings": {
        "BAN_QT_RCC": "/Users/user_xxx/Programming/Qt/6.5.0/macos/libexec/rcc",
        "BAN_QT_LUPDATE": "/Users/user_xxx/Programming/Qt/6.5.0/macos/bin/lupdate",
        "BAN_QT_LRELEASE": "/Users/user_xxx/Programming/Qt/6.5.0/macos/bin/lrelease",
        "BAN_EXE_PATH": "/Users/user_xxx/Programming/Repo/Banana/build/bin/BananaPlus.app/Contents/MacOS/BananaPlus",
    }
}
````

Install the following extension:

- twxs.cmake: CMake language support for Visual Studio Code (twsx)
- ms-vscode.cmake-tools: CMake Tools (microsoft)
