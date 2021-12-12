
// класс - абстракция "Телевизор"
class Television {
    var firmAndModel: (String, String)
    var isSwitchedOn: Bool
    var currentChannel: Channel
    
    // метод, показывающий текущий канал
    func showCurrentChannel(from TV: Television) {
        if TV.isSwitchedOn {
            print("Вы смотрите канал: \(TV.currentChannel.rawValue)")
        } else {
            print("Телевизор выключен")
        }
    }
    
    // конструктор класса
    init(firmAndModel: (String, String), isSwitchedOn: Bool, currentChannel: Channel) {
        self.firmAndModel = firmAndModel
        self.isSwitchedOn = isSwitchedOn
        self.currentChannel = currentChannel
    }
}

// перечисление из каналов строкового типа
enum Channel: String {
    case first = "Первый"
    case second = "Россия24"
    case third = "НТВ"
    case fourth = "Домашний"
    case fifth = "Дождь"
    case sixth = "MTV"
}

// новый экземпляр класса и вызываем метод по показу текущего канала
var myTV = Television(firmAndModel: ("Sony", "Bravia"), isSwitchedOn: true, currentChannel: Channel.fifth)
myTV.showCurrentChannel(from: myTV)

// "состояние" экземпляра меняется - телевизор выключили
myTV = Television(firmAndModel: ("Sony", "Bravia"), isSwitchedOn: false, currentChannel: Channel.second)
myTV.showCurrentChannel(from: myTV)

// новый класс - наследник предыдущего
class ModernTV: Television {
    var volume: Volume
    var colour: Colour
    
    // родительский метод изменен
    func showCurrentChannel(from TV: ModernTV) {
        if TV.isSwitchedOn {
            print("Вы смотрите канал: \(TV.currentChannel.rawValue). \(TV.colour.rawValue) \(TV.volume.rawValue)")
        } else {
            print("Телевизор выключен")
        }
    }
    
    init(firmAndModel: (String, String), isSwitchedOn: Bool, currentChannel: Channel, volume: Volume, colour: Colour) {
        self.volume = volume
        self.colour = colour
        super.init(firmAndModel: firmAndModel, isSwitchedOn: isSwitchedOn, currentChannel: currentChannel)
    }
}

// перечисление с "настройками громкости" телевизора
enum Volume: String {
    case soundOff = "Звук выключен."
    case soundOn = "Звук включен."
}

// перечисление с "настройки цветности картинки на экране"
enum Colour: String {
    case blackAndWhite = "Картинка Ч/Б."
    case color = "Картинка цветная."
}

//создаем экземпляр нового класса ModernTV и вызываем метод вывода сообщения на экран
var myModernTV = ModernTV(firmAndModel: ("Apple", "TV"), isSwitchedOn: true, currentChannel: Channel.first, volume: .soundOff, colour: .blackAndWhite)
myModernTV.showCurrentChannel(from: myModernTV)

// новый класс - наследник предыдущих классов
class SuperModernTV: ModernTV {
    var signalSource: SignalSource
    
    // обновили метод - добавили информацию об источнике видеосигнала
    func showCurrentChannel(from TV: SuperModernTV) {
        let currentSignalSource = TV.signalSource
        if TV.isSwitchedOn {
            switch currentSignalSource {
            case .tv(let value):
                print("В данный момент вы используете \(value)")
                print("Вы смотрите канал: \(TV.currentChannel.rawValue). \(TV.colour.rawValue) \(TV.volume.rawValue)")
            case .video(let value):
                print("В данный момент вы используете \(value)")
            }
        } else {
            print("Телевизор выключен")
        }
    }
    
    init(firmAndModel: (String, String), isSwitchedOn: Bool, currentChannel: Channel, volume: Volume, colour: Colour, signalSource: SignalSource) {
        self.signalSource = signalSource
        super.init(firmAndModel: firmAndModel, isSwitchedOn: isSwitchedOn, currentChannel: currentChannel, volume: volume, colour: colour)
    }
}

// перечисление с associated values (переключение "ТВ" - "видеомагнитофон")
enum SignalSource {
    case tv(String)
    case video(String)
}

var mySuperModenTV = SuperModernTV(firmAndModel: ("Apple", "New Apple TV"), isSwitchedOn: true, currentChannel: Channel.fourth, volume: .soundOn, colour: .color, signalSource: .video("видеомагнитофон"))
mySuperModenTV.showCurrentChannel(from: mySuperModenTV)
