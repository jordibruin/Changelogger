
import WebKit

struct HTMLView: NSViewRepresentable {
    let htmlContent: String

    func makeNSView(context: Context) -> WKWebView {
        
        let view = WKWebView()
        view.loadHTMLString(htmlContent, baseURL: nil)
        return WKWebView()
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(htmlContent, baseURL: nil)
    }
}