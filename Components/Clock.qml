import QtQuick 2.15
import SddmComponents 2.0

Clock {
  id: time
  color: config.lukadress
  timeFont {
    family: config.Font2
    pointSize: 220  // Set the desired font size for the time display
  }
  dateFont {
    family: config.Font1
    pointSize: 47  // Set the desired font size for the date display
  }
  anchors {
    bottom: parent.bottom
    left: parent.left  // Anchor to the left side of the parent
    leftMargin: 0    // Adds a margin to the left of the text, can be used to move the text to the right
    bottomMargin: 200
  }
}
