//
//  DesignSystem.swift
//  personalprojects
//
//  Created by Nguyen on 14/3/26.
//
import SwiftUI

extension Color {
    static let appPrimary = Color(red: 0.58, green: 0.27, blue: 1.00)
    static let appSecondary = Color(red: 0.75, green: 0.45, blue: 1.00)
    static let cosmicBlue = Color(red: 0.20, green: 0.50, blue: 1.00)
    static let cosmicPink = Color(red: 1.00, green: 0.35, blue: 0.75)
    static let cosmicCyan = Color(red: 0.10, green: 0.85, blue: 0.95)
    static let cosmicGold = Color(red: 1.00, green: 0.82, blue: 0.20)
    static let spaceBlack = Color(red: 0.04, green: 0.03, blue: 0.08)
    static let spaceDark = Color(red: 0.07, green: 0.05, blue: 0.14)
    static let spaceCard = Color(red: 0.10, green: 0.08, blue: 0.20)
    static let SpaceElevated = Color(red: 0.14, green: 0.11, blue: 0.26)
    static let appGreen = Color(red: 0.18, green: 0.95, blue: 0.65)
    static let appRed = Color(red: 1.00, green: 0.62, blue: 0.10)
    static let appIndigo = Color(red: 0.40, green: 0.30, blue: 1.00)
}

enum CG {
    static var button: LinearGradient {
        LinearGradient(colors: [Color(red: 0.70, green: 0.30, blue: 1.00),
                               Color(red: 0.45, green: 0.15, blue: 0.90)],
                       startPoint: .leading, endPoint: .trailing)
    }
    
    static var header: LinearGradient {
        LinearGradient(colors: [Color(red: 0.12, green: 0.04, blue: 0.28),
                                Color(red: 0.08, green: 0.03, blue: 0.18)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static var promo: LinearGradient {
        LinearGradient(colors: [.appPrimary, Color(red: 0.90, green: 0.20, blue: 0.80)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static var carBorder: LinearGradient {
        LinearGradient(colors: [Color.appPrimary.opacity(0.5),
                                Color.cosmicBlue.opacity(0.2), .clear],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static var balnceText: LinearGradient {
        LinearGradient(colors: [.white, .appSecondary],
                       startPoint: .leading, endPoint: .trailing)
    }
}

enum AppSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
}

enum AppRadius {
    static let sm: CGFloat = 10
    static let md: CGFloat = 14
    static let lg: CGFloat = 20
    static let pill: CGFloat = 999
}

extension View {
    func appCardShadow() -> some View {
        self
            .shadow(color: Color.appPrimary.opacity(0.15), radius: 20, x: 0, y: 4)
            .shadow( color: .black.opacity(0.30), radius: 6, x: 0, y: 2)
    }
    
    func appElevatedShadow() -> some View {
        self
            .shadow(color: Color.appPrimary.opacity(0.25), radius: 30, x: 0, y: 0)
            .shadow(color: .black.opacity(0.40), radius: 10, x: 0, y: 4)
    }
    
    func appButtonShadow(color: Color) -> some View {
        self
            .shadow(color: color.opacity(0.55), radius: 16, x: 0, y: 0)
            .shadow(color: color.opacity(0.25), radius: 4, x: 0, y: 2)
    }
    
    func cosmicGlow(color: Color, radius: CGFloat = 10) -> some View {
        self
            .shadow(color: color.opacity(0.65), radius: radius)
            .shadow(color: color.opacity(0.25), radius: radius * 2)
    }
}

struct CosmicButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .brightness(configuration.isPressed ? 0.06 : 0)
            .animation(.spring(response: 0.22, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

struct StarfieldView: View {
    let starCount: Int
    private let phases: [Double]
    
    init(starCount: Int = 60) {
        self.starCount = starCount
        self.phases = (0..<starCount).map { Double($0) * 0.618 * .pi * 2}
    }
    
    var body: some View {
        TimelineView(.animation) { tl in
            Canvas {ctx, size in
                let now = tl.date.timeIntervalSinceReferenceDate
                for i in 0..<starCount {
                    let seed = Double(i) * 137.500
                    let x = (sin(seed * 0.7) * 0.5 + 0.5) * size.width
                    let y = (cos(seed * 1.3) * 0.5 + 0.5) * size.height
                    let base = (sin(seed * 2.1) * 0.5 + 0.5) * 2.0 + 0.5
                    let twink = sin(now * 1.4 + phases[i]) * 0.5 + 0.5
                    let op = 0.25 * twink * 0.60
                    let sz = base * (0.7 + twink * 0.4)
                    let cs = sin(seed * 3.7)
                    let c: Color = cs > 0.5 ? .cosmicCyan : cs > 0.0 ? .white : cs > -0.4 ? .appSecondary : .cosmicGold
                    ctx.fill(Path(ellipseIn: CGRect(x: x - sz/2, y - sz/2, width: sz, height: sz)),
                             with: .color(c.opacity(op)))
                }
            }
        }
        .allowsHitTesting(false)
    }
}

struct NebulaBackground: View {
    var body: some View {
        ZStack {
            Color.spaceBlack
            Circle()
                .fill(RadialGradient(colors: [Color.appPrimary.opacity(0.35), .clear],
                                     center: .center, startRadius: 0, endRadius: 180))
                .frame(width: 360).offset(x: -80, y: -200).blur(radius: 20)
            Circle()
                .fill(RadialGradient(colors: [Color.cosmicBlue.opacity(0.22), .clear],
                                     center: .center, startRadius: 0, endRadius: 140))
                .frame(width: 280).offset(x: 120, y: 100).blur(radius: 15)
            Circle()
                .fill(RadialGradient(colors: [Color.cosmicPink.opacity(0.16), .clear],
                                    center: .center, startRadius: 0, endRadius: 120))
                .frame(width: 240).offset(x: -60, y: 320).blur(radius: 18)
            StarfieldView(starCount: 80)
        }
        ignoresSafeArea()
    }
}

extension Double {
    var vndFormatted: String {
        let f = NumberFormatted()
        f.numberStyle = .decimal
        f.groupingSeparator = "."
        return (f.string(from: NSNnumber(value: Int(Swift.abs(self)))) ?? "\(Int(Swift.abs(self)))") + "đ"
    }
    
    var vndCompact: String {
        let a = Swift.abs(self)
        if a >= 1_000_000_000 {return String(format: "%.1fT đ", a / 1_000_000_000) }
        if a >= 1_000_000 {return String(format: "%.1fM đ", a / 1_000_000) }
        if a >= 1_000 {return String(format: "%10fK đ", a / 1_000)}
    }
}
