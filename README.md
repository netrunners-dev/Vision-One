<h1 align="center">Vision One</h1>

<p align="center">
<img src="https://i.imgur.com/wsfT3lK.png" width="150"/>
<br/>
<b>A gadget that turns any pair of glasses into smart ones</b>
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

Vision One is a gadget that transforms any glasses into a smart device. This attachment seamlessly integrates with your existing glasses, adding a layer of intelligent functionality without affecting your current eyewear!

![Vision One Gadget](https://i.imgur.com/exA8xss.png)

## 🔋 Features

Some of the features that the Vision One provides are:

- **Real-time Speech To Text**: From now on, even the deaf can hear
- **AI Mode**: ChatGPT at your fingertips
- **Music Mode**: Media player inside your glasses

## 🏗️ How to build
### Hardware

#### Things you will need:
- Arduino Pro Micro
- HC-05/06
- ST7735 TFT LCD 0.96" SPI 80x160px
- Charging module
- Li-Ion battery 3.7v 650mAh 
- Push button
- Slide switch
- 10kΩ Resistor
- DuPont Wires
- Soldering Iron
- 3D Printer
- Paint (optional, in case you want to paint it after printing)

#### 3D Printing
##### Print settings
- Layer height: 0.08mm-0.10mm
- Brim: On
- Supports: Custom preferably (only needed for the main case, for side holes & the slit for the glasses, NOT the letters)
- Material: PLA
- Hotend Temps: 210c first layer, 205c other layers
- Bed Temps: 60c
- Infill: Doesn't matter

##### Files
3D Printing Files are available [here.](https://github.com/netrunners-dev/Vision-One/releases)

⚠️ **When printing the "Clip", you should split it into two separate pieces (cut it in half in your preferred slicer) and then glue it together - Why? It's not the easiest model to print and we've had some issues with supports not being easy to remove, causing further issues during the assembly.**

#### Schema
While the case is being printed, we can start connecting the components based on this schema. 

⚠️ **The battery checking part of the circuit is not present on the schema due to it not being the most accurate thing out there. Pin 2 is the pin used to check the battery level. You'll need to create a simple voltage divider for this. For this part, you're completely on your own. Sorry!**

![Schema for connecting all components](https://imgur.com/TYIjHpO.png)

Once the components are all connected, before putting them all in the case, [set up the Arduino](#setup-arduino).

### Software

To build the application, the following software must be installed on your computer:

- [Arduino IDE](https://www.arduino.cc/en/software)
- [Flutter](https://docs.flutter.dev/get-started/install)
- [Git](https://git-scm.com/)

After installing the required tools, follow these steps:


#### Setup Arduino

1. **Get .ino file**

    Head to the [GitHub releases](https://github.com/netrunners-dev/Vision-One/releases) and grab the ```.ino``` file.

2. **Flash Arduino**

    Launch the Arduino IDE and open the downloaded .ino file. Connect your Arduino to your computer using a USB cable and upload the code to the Arduino board.

#### Build the application

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

4. **Create and populate the .env template**
   ```shell
    OPEN_AI_API_KEY=""
    ```
    > File **must** be created in lib folder. You can obtain OpenAI Key [here](https://openai.com/).

5. **Build the application**
   ```shell
    flutter build apk
    ```
    > You should get something like this 
    ```✓  Built build\app\outputs\flutter-apk\app-release.apk (23.2MB).```

6. **Transfer .apk file to phone and install it**


## ⚙️ Configuration

1. **Open the Vision One Application**

2. **Give the app required permissions**

   ![GIF - How to enable permissions](https://i.imgur.com/UANweEr.gif)

3. **Find the MAC Address of your HC-06**
   > [This](https://medium.com/@mohamadamgad09/how-to-get-hc-05-hc-06-mac-address-16ed54bf390) can help you.

4. **Connecting to the gadget**
   
   Enter your MAC address in settings and choose the macro mode.
   After configuring your settings, press apply and wait for it to connect.
   
   ![GIF - How to connect to gadget](https://imgur.com/XQKotli.gif)


## 📝 Usage

1. **Default mode**

     When no other modes are active, your device will automatically display the current local time.

2. **Activate Music mode**
   
     Tap the music button. This will allow you to play any song or video, with the title, artist, and duration displayed on screen. To deactivate Music Mode, simply tap the button again.

3. **Activate Speech-To-Text mode**

    Tap the speech-to-text button. A "bleep"-like sound will indicate when you can begin speaking. Text will be displayed on the screen, with a slight delay, displaying what the other party is saying. Another "boop" sound will signal the end of speech recognition.

4. **Activate AI mode**

    Tap the AI button. A "bleep" will let you know when it's ready for your question. Once you ask your question, you will hear another "bleep", followed by the answer getting displayed on the screen.

5. **Refresh Battery Level**

    Tapping the battery refresh button in the app will update the battery percentage.

## Contact

If you have any questions, suggestions, or feature requests, please feel free to reach out to us trough our [e-mail](mailto:contact@netrunners.work)!

## Credits

- **Designer + Arduino programmer** - @nikolchaa
  - [GitHub](https://github.com/nikolchaa)
  - [LinkedIn](https://www.linkedin.com/in/nikolchaa/)

- **Mobile application developer** - @lukaarakic
  - [GitHub](https://github.com/lukaarakic)
  - [LinkedIn](https://www.linkedin.com/in/lukaarakic/)
