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
    - [Setup Arduino](#setup-arduino)
    - [Build application](#build-application)
- **[Configuration](#⚙️-configuration)**
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

#### 3D Printing
Before we connect all the components, we will put the case to print.
(coming soon).

#### Schema
While the case is being printed, we can start connecting the components based on this schema.

![Schema for connecting all components](https://imgur.com/TYIjHpO.png)

Once the components are soldered together, before putting them all in the case do this [first](#setup-arduino).

### Software

To build application, you need to have [Arduino IDE](https://www.arduino.cc/en/software), [Flutter](https://docs.flutter.dev/get-started/install) and [Git](https://git-scm.com/) installed on your machine. After installing tools follow these steps:


#### Setup Arduino

1. **Get .ino file**

    Head to the GitHub releases and grab the ```.ino``` file.

2. **Flash Arduino**

    Launch the Arduino IDE and open the downloaded .ino file. Connect your Arduino to your computer using a USB cable and upload the code to the Arduino board.

#### Build application

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

6. **Transfer .apk file to phone and install it**


## ⚙️ Configuration

1. **Open Vision One Application**

2. **Agree to all permissions**
   
    <img src="https://imgur.com/riFH33P.gif" height="500px"/>


3. **Find MAC Address of your HC-06**
   > [This](https://medium.com/@mohamadamgad09/how-to-get-hc-05-hc-06-mac-address-16ed54bf390) can help you.

4. **Connecting to gadget**
   
   Enter your MAC address in settings and choose macro mode.
   After configuration press apply and wait for connection.
   <img src="https://imgur.com/KAmRQhQ.gif" height="500px"/>


## 📝 Usage

1. **Default mode**

     When no other modes are active, your device will automatically display the current local time.

2. **Activate Music mode**
   
     Tap the music button. This will allow you to play any song or video, with the title, artist, and duration displayed on screen. To deactivate Music Mode, simply tap the button again.

3. **Activate Speech-To-Text mode**

    Tap the speech-to-text button. A "boop" sound will indicate when you can begin speaking. Your speech will be displayed on the screen, with a slight delay of one second. Another "boop" sound will signal the end of speech recognition.

4. **Activate AI mode**

    Tap the AI button. A "boop" will let you know it's ready for your question. Once you ask your question, another "boop" will sound, followed by the answer displayed on the screen.

5. **Refresh Battery Level**

    Tapping the battery refresh button in the app will update the battery percentage in real-time.

## Contact

If you have any questions, suggestions, or feature requests, please feel free to reach out to us trough [Mail](mailto:contact@netrunners.work).

## Credits

- **Designer + Arduino programmer** - @nikolchaa
  - [GitHub](https://github.com/nikolchaa)
  - [LinkedIn](https://www.linkedin.com/in/nikolchaa/)

- **Mobile application developer** - @lukaarakic
  - [GitHub](https://github.com/lukaarakic)
  - [LinkedIn](https://www.linkedin.com/in/lukaarakic/)