extension Int {
    init(entropySecurity: EntropySecurity) {
        switch entropySecurity {
        case .weakest:
            self = 128
        case .weak:
            self = 160
        case .medium:
            self = 192
        case .strong:
            self = 224
        case .strongest:
            self = 256
        }
    }
}
