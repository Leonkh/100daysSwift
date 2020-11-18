//
//  ViewController.swift
//  Project27
//
//  Created by Леонид Хабибуллин on 17.11.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        drawRectangle()
//        drawStar() // Challenge 1
        drawTwin() // Challenge 2
    }
    
    
    func drawRectangle() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512)) // Создаем класс UIGraphicsImageRenderer из UIKit, который будет соединять CoreGraphics с нашим UIKit. Мы создали поле для рендера изображений
        
        let img = render.image { ctx in // само рисование будет в закрытии
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512) // сделали скетч
            
            // задаем параметры
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle) // задали путь
            ctx.cgContext.drawPath(using: .fillStroke) // рисуем путь
        }
        
        imageView.image = img
    }
    
    func drawCircle() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512)) // Создаем класс UIGraphicsImageRenderer из UIKit, который будет соединять CoreGraphics с нашим UIKit. Мы создали поле для рендера изображений
        
        let img = render.image { ctx in // само рисование будет в закрытии
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 15 , dy: 15) // сделали скетч, c отступом от каждого края по 5
            
            // задаем параметры
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle) // задали путь
            ctx.cgContext.drawPath(using: .fillStroke) // рисуем путь
        }
        
        imageView.image = img
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)

            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }

        imageView.image = img
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

            let img = renderer.image { ctx in
                ctx.cgContext.translateBy(x: 256, y: 256)

                let rotations = 16
                let amount = Double.pi / Double(rotations)

                for _ in 0 ..< rotations {
                    ctx.cgContext.rotate(by: CGFloat(amount))
                    ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
                }

                ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
                ctx.cgContext.strokePath()
            }

            imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            var first = true
            var length: CGFloat = 256

            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)

                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }

                length *= 0.99
            }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = img
    }
    
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
                    ]
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil) //  рисуем в конкретной области
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150)) // рисовка изображений
                }
        

        imageView.image = img
    }
    
    func drawStar() { // challenge 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.translateBy(x: 256, y: 256) // начинаем чертить с центра
            
            let lenght: CGFloat = 100
            var first = true
            var second = false
            let angle: CGFloat =  2.51327//0.628319 // 36 градусов в радианах
            
            for _ in 0...5 {
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: lenght, y: 50)) // идем от центра к первой точке
                    first = false
                } else {
                    if !second{
                ctx.cgContext.rotate(by: angle)
                    }
                ctx.cgContext.addLine(to: CGPoint(x: lenght, y: 50))
                }
            }
            ctx.cgContext.rotate(by: .pi / 4)
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
    }
    
    func drawTwin() { // challenge 2
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.move(to: CGPoint(x: 25, y: 250)) // начальная точка
            // T
            ctx.cgContext.addLine(to: CGPoint(x: 25, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 0, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 50, y: 100))
            // W
            ctx.cgContext.move(to: CGPoint(x: 75, y: 100))
            
            ctx.cgContext.addLine(to: CGPoint(x: 125, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 175, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 225, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 275, y: 100))
            // I
            ctx.cgContext.move(to: CGPoint(x: 300, y: 100))
            
            ctx.cgContext.addLine(to: CGPoint(x: 350, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 325, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 325, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 300, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 350, y: 250))
            
            // N
            ctx.cgContext.move(to: CGPoint(x: 400, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 400, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 500, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 500, y: 100))
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
        
    }
    
//    @IBAction func redrawTapped(_ sender: Any) {
//                currentDrawType += 1
//
//                if currentDrawType > 6 {
//                    currentDrawType = 0
//                }
//
//                switch currentDrawType {
//                case 0:
//                    drawRectangle()
//                case 1:
//                    drawCircle()
//                case 2:
//                    drawCheckerboard()
//                case 3:
//                    drawRotatedSquares()
//                case 4:
//                    drawLines()
//                case 5:
//                    drawImagesAndText()
//                case 6:
//                    drawStar()
//                default:
//                    break
//                }
//    }
    

    
}

