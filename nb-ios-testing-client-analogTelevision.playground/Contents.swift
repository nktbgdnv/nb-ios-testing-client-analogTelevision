//
// N. Bogdanov 2021
// class - abstraction "TV"
//
class Television {
    var firmAndModel: (String, String)
    var isSwitchedOn: Bool
    var currentChannel: Channel
    
    init(firmAndModel: (String, String), isSwitchedOn: Bool, currentChannel: Channel) {
        self.firmAndModel = firmAndModel
        self.isSwitchedOn = isSwitchedOn
        self.currentChannel = currentChannel
    }
    
    // method showing the current channel
    func showCurrentChannel(from TV: Television) {
        if TV.isSwitchedOn {
            print("You are watching the channel: \(TV.currentChannel.rawValue)")
        } else {
            print("TV off")
        }
    }
}

// enumeration from channels of string type
enum Channel: String {
    case first = "First"
    case second = "Russia24"
    case third = "NTV"
    case fourth = "Home"
    case fifth = "TVRain"
    case sixth = "MTV"
}

// a new instance of the class and call the method to show the current channel
var myTV = Television(firmAndModel: ("Sony", "Bravia"), isSwitchedOn: true, currentChannel: Channel.fifth)
myTV.showCurrentChannel(from: myTV)

// the "state" of the instance changes - the TV is turned off
myTV = Television(firmAndModel: ("Sony", "Bravia"), isSwitchedOn: false, currentChannel: Channel.second)
myTV.showCurrentChannel(from: myTV)

class ModernTV: Television {
    var volume: Volume
    var colour: Colour
    
    func showCurrentChannel(from TV: ModernTV) {
        if TV.isSwitchedOn {
            print("You are watching the channel: \(TV.currentChannel.rawValue). \(TV.colour.rawValue) \(TV.volume.rawValue)")
        } else {
            print("TV is off")
        }
    }
    
    init(firmAndModel: (String, String), isSwitchedOn: Bool, currentChannel: Channel, volume: Volume, colour: Colour) {
        self.volume = volume
        self.colour = colour
        super.init(firmAndModel: firmAndModel, isSwitchedOn: isSwitchedOn, currentChannel: currentChannel)
    }
}

// enumeration with the "volume settings" of the TV
enum Volume: String {
    case soundOff = "The sound is turned off."
    case soundOn = "The sound is on."
}

// enumeration with "setting the color of the picture on the screen"
enum Colour: String {
    case blackAndWhite = "B / W picture."
    case color = "Color picture."
}

// create an instance of the new ModernTV class and call the method to display the message on the screen
var myModernTV = ModernTV(firmAndModel: ("Apple", "TV"), isSwitchedOn: true, currentChannel: Channel.first, volume: .soundOff, colour: .blackAndWhite)
myModernTV.showCurrentChannel(from: myModernTV)

// the new class is the inheritor of the previous classes
class SuperModernTV: ModernTV {
    var signalSource: SignalSource
    
    // updated the method - added information about the video source
    func showCurrentChannel(from TV: SuperModernTV) {
        let currentSignalSource = TV.signalSource
        if TV.isSwitchedOn {
            switch currentSignalSource {
            case .tv(let value):
                print("You are currently using \(value)")
                print("You are watching the channel: \(TV.currentChannel.rawValue). \(TV.colour.rawValue) \(TV.volume.rawValue)")
            case .video(let value):
                print("You are currently using \(value)")
            }
        } else {
            print("TV off")
        }
    }
    
    init(firmAndModel: (String, String), isSwitchedOn: Bool, currentChannel: Channel, volume: Volume, colour: Colour, signalSource: SignalSource) {
        self.signalSource = signalSource
        super.init(firmAndModel: firmAndModel, isSwitchedOn: isSwitchedOn, currentChannel: currentChannel, volume: volume, colour: colour)
    }
}

// enumeration with associated values ​​(toggle "TV" - "VCR")
enum SignalSource {
    case tv(String)
    case video(String)
}

var mySuperModenTV = SuperModernTV(firmAndModel: ("Apple", "New Apple TV"), isSwitchedOn: true, currentChannel: Channel.fourth, volume: .soundOn, colour: .color, signalSource: .video("VCR"))
mySuperModenTV.showCurrentChannel(from: mySuperModenTV)
