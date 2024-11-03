import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session
  property var inputHeight: Screen.height * 0.032
  property var inputWidth: Screen.width * 0.16
  //I recommed that you pin the object first to either the top-leff, bottom-left etc using
  //left: parent.left
  //top:parent.top
  //
  //
  //now we can add margins to easily move the object around the Screen
  //ive only researched qml for like 3 hours so this approach may be rudimentary so feel free to suggest better methods lol
  Rectangle {
    id: loginBackground
    anchors {
      top: parent.top
      left: parent.left
      leftMargin: 70
      topMargin: 800
    }
    height: inputHeight * 5.3
    width: inputWidth * 1.35
    radius: 30
    opacity: 0.3
    visible: config.LoginBackground == "true" ? true : false
    color: config.rosewater
  }
  Column {
    spacing: 8
    anchors {
      bottom: parent.bottom
      left: parent.left
    }
    PowerButton {
      id: powerButton
    }
    RebootButton {
      id: rebootButton
    }
    SleepButton {
      id: sleepButton
    }
    z: 5
  }
  Column {
    spacing: 8
    anchors {
      bottom: parent.bottom
      right: parent.right
    }
    SessionPanel {
      id: sessionPanel
    }
    z: 5
  }
  Column {
    spacing: 8
    z: 5
    width: inputWidth
    anchors {
      top: parent.top
      left: parent.left
      leftMargin: 117
      topMargin: 827
    }
    UserField {
      id: userField
      height: inputHeight * 1.1
      width: parent.width
    }
    PasswordField {
      id: passwordField
      height: inputHeight * 1.1
      width: parent.width
      onAccepted: loginButton.clicked()
    }
    Button {
      id: loginButton
      height: inputHeight * 1.1
      width: parent.width
      enabled: user != "" && password != "" ? true : false
      hoverEnabled: true
      contentItem: Text {
        id: buttonText
        renderType: Text.NativeRendering
        font {
          family: config.Font
          pointSize: config.FontSize
          bold: true
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.crust
        text: "Login"
      }
      background: Rectangle {
        id: buttonBackground
        color: config.flamingo
        radius: 10
      }
      states: [
        State {
          name: "pressed"
          when: loginButton.down
          PropertyChanges {
            target: buttonBackground
            color: config.rosewater
          }
          PropertyChanges {
            target: buttonText
          }
        },
        State {
          name: "hovered"
          when: loginButton.hovered
          PropertyChanges {
            target: buttonBackground
            color: config.rosewater
          }
          PropertyChanges {
            target: buttonText
          }
        },
        State {
          name: "enabled"
          when: loginButton.enabled
          PropertyChanges {
            target: buttonBackground
          }
          PropertyChanges {
            target: buttonText
          }
        }
      ]
      transitions: Transition {
        PropertyAnimation {
          properties: "color"
          duration: 300
        }
      }
      onClicked: {
        sddm.login(user, password, session)
      }
    }
  }
  Connections {
    target: sddm

    function onLoginFailed() {
      passwordField.text = ""
      passwordField.focus = true
    }
  }
}
