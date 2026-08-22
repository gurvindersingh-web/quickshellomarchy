import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "gurvindersingh-web.system-stats"

  property string tempText: "..."
  property string powerText: "..."
  property string cpuText: "..."
  property string memText: "..."
  property string diskText: "..."
  property string uptimeText: "..."

  implicitWidth: row.implicitWidth + Style.space(16)
  implicitHeight: barSize

  Process {
    id: monProc
    command: ["bash", Qt.resolvedUrl("stats.sh").toString().replace("file://", "")]
    stdout: StdioCollector {
      id: monOut
      waitForEnd: true
    }
    onExited: function(exitCode) {
      if (exitCode === 0) {
        try {
          let data = JSON.parse(monOut.text.trim());
          root.tempText = data.temp;
          root.powerText = data.power;
          root.cpuText = data.cpu;
          root.memText = data.mem;
          root.diskText = data.disk;
          root.uptimeText = data.uptime;
        } catch(e) { }
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      if (!monProc.running) monProc.running = true;
    }
  }

  component StatItem : Item {
    id: statItemRoot
    property string text
    property color accentColor: "#89b4fa"
    signal clicked()
    signal rightClicked()
    
    implicitWidth: label.implicitWidth + Style.space(24)
    implicitHeight: root.barSize - Style.space(12)
    anchors.verticalCenter: parent.verticalCenter

    Rectangle {
      anchors.fill: parent
      radius: height / 2
      color: ma.containsMouse ? Qt.rgba(parent.accentColor.r, parent.accentColor.g, parent.accentColor.b, 0.2) : Qt.rgba(0.5, 0.5, 0.5, 0.1)
      border.width: 1
      border.color: ma.containsMouse ? Qt.rgba(parent.accentColor.r, parent.accentColor.g, parent.accentColor.b, 0.5) : "transparent"
      Behavior on color { ColorAnimation { duration: 150 } }
      Behavior on border.color { ColorAnimation { duration: 150 } }
    }

    Text {
      id: label
      anchors.centerIn: parent
      text: parent.text
      color: ma.containsMouse ? parent.accentColor : (root.bar ? root.bar.barForeground : Color.foreground)
      font.family: "JetBrainsMono Nerd Font"
      font.pixelSize: Style.font.bodySmall
      font.bold: true
      Behavior on color { ColorAnimation { duration: 150 } }
    }

    MouseArea {
      id: ma
      anchors.fill: parent
      hoverEnabled: true
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      onClicked: (mouse) => {
        if (mouse.button === Qt.RightButton) {
          statItemRoot.rightClicked();
        } else {
          statItemRoot.clicked();
        }
      }
    }
  }

  Row {
    id: row
    anchors.centerIn: parent
    spacing: Style.space(8)

    StatItem {
      text: root.tempText
      accentColor: "#f38ba8"
      onClicked: { root.bar.run("alacritty -e btop"); }
    }
    StatItem {
      text: root.powerText
      accentColor: root.powerText.includes("") ? "#a6e3a1" : root.powerText.includes("") ? "#f9e2af" : "#f38ba8"
      onClicked: { root.bar.run("omarchy-shell omarchy.power toggle"); }
    }
    StatItem {
      text: root.cpuText
      accentColor: "#89b4fa"
      onClicked: { root.bar.run("alacritty -e btop"); }
      onRightClicked: { root.bar.run("alacritty"); }
    }
    StatItem {
      text: root.memText
      accentColor: "#cba6f7"
      onClicked: { root.bar.run("alacritty -e btop"); }
    }
    StatItem {
      text: root.diskText
      accentColor: "#fab387"
      onClicked: { root.bar.run("alacritty -e btop"); }
    }
    StatItem {
      text: root.uptimeText
      accentColor: "#94e2d5"
    }
  }
}
