import Foundation

protocol LeapQuestFrogViewModelDelegate: AnyObject {
    func leapQuestFrogViewModelDidUpdate()
}

protocol LeapQuestAchievementsViewModelDelegate: AnyObject {
    func leapQuestAchievementsViewModelDidUpdate()
}

protocol LeapQuestPuzzlesViewModelDelegate: AnyObject {
    func leapQuestPuzzlesViewModelDidUpdate()
}

protocol LeapQuestCatalogViewModelDelegate: AnyObject {
    func leapQuestCatalogViewModelDidUpdate()
}

protocol LeapQuestSettingsViewModelDelegate: AnyObject {
    func leapQuestSettingsViewModelDidUpdate()
}

protocol LeapQuestSettingsSwitchDelegate: AnyObject {
    func leapQuestSettingsSwitchDidChange(_ item: LeapQuestSettingsItemModel, isOn: Bool)
}


