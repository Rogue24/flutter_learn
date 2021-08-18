//
//  Lottie.Extension.swift
//  Neves_Example
//
//  Created by aa on 2020/10/26.
//

struct ImageReplacementProvider: AnimationImageProvider {
    let replacement: [String: CGImage?]?
    let fileProvider: FilepathImageProvider
    
    init(imageReplacement: [String: CGImage?]?, filePath: String) {
        replacement = imageReplacement
        fileProvider = FilepathImageProvider(filepath: filePath)
    }
    
    func imageForAsset(asset: ImageAsset) -> CGImage? {
        if let cgImg = replacement?[asset.name] {
            return cgImg
        }
        return fileProvider.imageForAsset(asset: asset)
    }
}

extension JP where Base: AnimationView {
    static func build(_ dirName: String, _ imageReplacement: [String: CGImage?]? = nil) -> Base {
        guard let filepath = Bundle.main.path(forResource: "data", ofType: "json", inDirectory: "lottie/\(dirName)") else { fatalError("路径错误！") }
        if let imageReplacement = imageReplacement {
            let path = URL(fileURLWithPath: filepath).deletingLastPathComponent().path
            let imageProvider = ImageReplacementProvider(imageReplacement: imageReplacement, filePath: path)
            return Base.init(filePath: filepath, imageProvider: imageProvider)
        } else {
            return Base.init(filePath: filepath)
        }
    }
}
