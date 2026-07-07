import SwiftUI

struct DarkModeToolbarButton : View {
    @EnvironmentObject var uiColorController: UIColorController
    var body: some View {
        Button
        {
            uiColorController.toggleDarkMode()
        }
    label:
        {
            Image(systemName: uiColorController.forceDarkMode ? "moon.fill" : "moon")
        }
        
    }
}
