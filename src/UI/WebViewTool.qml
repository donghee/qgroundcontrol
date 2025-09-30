/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
//import QtWebEngineQuick
import QtQuick.Window
import QtWebEngine

import QGroundControl
import QGroundControl.ScreenTools
import QGroundControl.Controls
import QGroundControl.Palette

Item {
    id: webViewRoot

    property string url: "http://localhost:8000"
    signal popout()

    ColumnLayout {
        anchors.fill: parent
        spacing: ScreenTools.defaultFontPixelHeight / 2

        RowLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelWidth
            visible: false  // 기본으로 주소줄 숨김

            QGCButton {
                text: qsTr("Back")
                enabled: webView.canGoBack
                onClicked: webView.goBack()
            }

            QGCButton {
                text: qsTr("Forward")
                enabled: webView.canGoForward
                onClicked: webView.goForward()
            }

            QGCButton {
                text: qsTr("Reload")
                onClicked: webView.reload()
            }

            QGCTextField {
                id: urlField
                Layout.fillWidth: true
                text: webView.url
                onAccepted: {
                    if (text.indexOf("://") < 0) {
                        text = "https://" + text
                    }
                    webView.url = text
                }
            }

            QGCButton {
                text: qsTr("Go")
                onClicked: {
                    var url = urlField.text
                    if (url.indexOf("://") < 0) {
                        url = "https://" + url
                    }
                    webView.url = url
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "white"

            WebEngineView {
                id: webView
                anchors.fill: parent
                url: webViewRoot.url
                onLoadingChanged: function(loadRequest) {
                    if (loadRequest.status === WebEngineLoadRequest.LoadSucceededStatus) {
                        urlField.text = url.toString()
                    }
                }
            }
        }
    }
}

