import Foundation
import ServiceManagement

final class StartAtLoginService {
    private enum Constant {
        static let didAttemptKey = "StartAtLoginService.didAttemptToEnableStartAtLogin"
    }

    private let defaults: UserDefaults

    private var didAttempt: Bool {
        get { defaults.bool(forKey: Constant.didAttemptKey) }
        set { defaults.set(newValue, forKey: Constant.didAttemptKey) }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func enableStartAtLogin() {
        if #available(macOS 13.0, *) {
            let service: SMAppService = .mainApp

            guard !didAttempt, service.status != .enabled else {
                return
            }

            try? service.register()
            didAttempt = true
        }
    }
}
