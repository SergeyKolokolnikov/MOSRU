
import Foundation

protocol SpeechRecDelegate {
    func recognizedTextDidChange(speechRec: SpeechRec, text: String)
}
