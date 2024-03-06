<h1 align="center">Vision One</h1>

<p align="center">
<img src="https://i.imgur.com/wsfT3lK.png" width="150"/>
<br/>
<b>A gadget that makes any pair of glasses into smart ones</b>
<br />
🌐 <a href="https://vision-one.netrunners.work/">vision-one.netrunners.work</a></b>
</p>


## 📋 Table of Contents

- **[About](#❓-about)**
- **[Features](#🔋-features)**
- **[How to build](#🏗️-how-to-build)**
  - [Hardware](#hardware)
    - [Thing you will need](#thing-you-will-need)
    - [3D Printing](#3d-printing)
    - [Schema](#schema)
  - [Software](#software)
- **[Usage](#📝-usage)**

## ❓ About

Vision One is a gadget that transforms any glasses into a smart device. This clip-on attachment seamlessly integrates with your existing lenses, adding a layer of intelligent functionality without affecting your current eyewear.

![Vision One Gadget](https://i.imgur.com/exA8xss.png)

## 🔋 Features

Some of the features Vision One provides are:

- **Real-time Transcription**: From now on, even the deaf can hear
- **AI Mode**: Wikipedia at your fingertips
- **Music Mode**: Media player in your glasses

## 🏗️ How to build
### Hardware

#### Thing you will need:
- Arduino Pro Micro
- HC-06
- ST7735 TFT LCD 0.96" SPI 80x160px
- Charging module
- Li-Ion battery 3.7v 650mAh
- Push button
- Slide switch
- 10kΩ Resistor
- Jumper Cables
- Soldering Iron
- 3D Printer
- Paint (optional)

##### 3D Printing
Before we connect all the components, we will put the case to print
(coming soon).

##### Schema
While the case is being printed, we can start connecting the components based on this schema

![Schema for connecting all components](https://imgur.com/TYIjHpO.png)

Once the components are soldered together, put them all in the 3D printed case.

### Software

To build application, you need to have [Flutter](https://docs.flutter.dev/get-started/install) and [Git](https://git-scm.com/) installed on your machine. After installing tools follow these steps:

1. **Clone the repository**
    ```shell
    git clone https://github.com/netrunners-dev/Vision-One.git
    ```
  
2. **Navigate to the project directory:**
    ```shell
    cd Vision-One
    ```

3. **Install dependencies**
   ```shell
    flutter pub get
    ```

4. **Create and populate .env template**
   ```shell
    OPEN_AI_API_KEY=""
    ```
    > File **must** be created in lib folder. You can obtain OpenAI Key [here](https://openai.com/).

5. **Build application**
   ```shell
    flutter build apk
    ```
    > You should get something like this 
    ```✓  Built build\app\outputs\flutter-apk\app-release.apk (23.2MB).```

6. **Transfer .apk file to phone and enjoy 🥳**


## 📝 Usage