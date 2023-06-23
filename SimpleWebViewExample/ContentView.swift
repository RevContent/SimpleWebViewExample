//
//  ContentView.swift
//  SimpleWebViewExample
//
//  Created by John Burnette on 6/23/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlFileName: String
    
    private let webView = WKWebView()
    
    func makeUIView(context: Context) -> some UIView {
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        webView.load(htmlFileName)
    }
}

extension WKWebView {
    func load(_ htmlFileName: String) {
        
        // These guards are optional. They perform some validation to ensure that a valid
        // URL or file is supplied. If you do not require this behavior, you can omit them
        guard !htmlFileName.isEmpty else  {
            return print("You must pass a valid file name")
        }
        
        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") else {
            return print("Invalid file path was supplied")
        }
        
        // This is the base url of the index.html located in this repository. More often than not,
        // this will be sufficient for your needs
        let bundleUrl = Bundle.main.url(forResource: htmlFileName, withExtension: "html")
        
        // In some cases, you may want to consider passing query parameters to the local html page.
        // If needed, you can add them to the url that is loaded like the following:
        // let fullUrl = URL(string: "?queryParam=test", relativeTo: bundleUrl)
        
        // In other cases, you may consider hosting your page and loading it remotely. To do so,
        // create a URL and pass the remote address to it like the following:
        // let remoteUrl = URL(string: "https://www.google.com");
        
        
        // Finally, the request is created
        let request = URLRequest(url: bundleUrl!)
        
        
        // This check is optional. It will try to parse the contents of the HTML file to ensure that
        // it is valid. If you don't require this behavior, you can omit this do block and simply call
        // load
        do {
            _ = try String(contentsOfFile: filePath, encoding: .utf8)
            load(request)
        } catch {
            print("There was a problem loading the html file")
        }
        
    }
}

struct ContentView: View {
    var body: some View {
        WebView(htmlFileName: "index")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
