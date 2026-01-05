import UIKit
import Flutter
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    // 1. تعريف حقل نصي مخفي
    private var field = UITextField()

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // 2. استدعاء وظيفة الحماية عند تشغيل التطبيق
        addSecuredView()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // 3. إيقاف الحماية مؤقتاً عند خروج التطبيق للخلفية (لتجنب المشاكل البرمجية)
    override func applicationWillResignActive(_ application: UIApplication) {
        field.isSecureTextEntry = false
    }

    // 4. إعادة تفعيل الحماية عند عودة التطبيق للعمل
    override func applicationDidBecomeActive(_ application: UIApplication) {
        field.isSecureTextEntry = true
    }

    // 5. الوظيفة الرئيسية التي تقوم بخدعة الحماية
    private func addSecuredView() {
        guard let window = self.window else { return }

        if (!window.subviews.contains(field)) {
            window.addSubview(field)
            field.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
            field.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            window.layer.superlayer?.addSublayer(field.layer)
            
            if #available(iOS 17.0, *) {
                field.layer.sublayers?.last?.addSublayer(window.layer)
            } else {
                field.layer.sublayers?.first?.addSublayer(window.layer)
            }
        }

        // Make the field secure to trigger screenshot protection
        field.isSecureTextEntry = true
    }
}
