# Flutter Package Integration Automation Tool

This is a desktop application built with Flutter to automate the process of adding packages to your Flutter projects. It allows users to easily select a Flutter project folder, choose a supported package, and start the integration process with minimal dependencies.

### Tested on MacOS platform

## Features
- **Project Folder Selection**: Easily browse and select the Flutter project folder to integrate packages into.
- **Supported Packages**: We currently support Google Maps SDK integration only for iOS & Android platforms.
- **Minimal Dependencies**: The app uses only the essential Flutter packages to keep it lightweight and efficient.
- **Integration Progress**: Start the integration process with a simple button, and see updates on the current integration status.


## Installation

1. Clone this repository to your local machine.

   ```bash
   git clone https://github.com/shihabkandil/flutter-package-auto-integration.git
   ```
   
2. Update dependencies
    ```bash
    flutter pub get
    ```

3. Run the application
    ```bash
    flutter run
    ```

## Usage
![alt text](https://github.com/shihabkandil/flutter-package-auto-integration/blob/develop/screenshot.png?raw=true)
1. **Select a Flutter Project**: Click the "Browse" button to choose the folder of your Flutter project.
2. **Choose a Package**: After selecting the project, pick a package from the dropdown list of supported packages.
3. **Start Integration**: Hit the "Start Integration" button to add the selected package to your project.
4. **Monitor Integration**: The tool will display updates as it integrates the package into the project.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---
Feel free to contribute or provide feedback to improve the tool!
