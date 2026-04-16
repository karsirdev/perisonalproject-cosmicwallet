import SwiftUI


struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            NebulaBackground()

            TabView(selection: $selectedTab) {
                HomeView(onNavigateToTab: { tab in
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.72)) { selectedTab = tab }
                })
                .tag(0)

                WalletView()
                    .tag(1)

                QRScanView()
                    .tag(2)

                PromotionView()
                    .tag(3)

                ProfileView()
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            CosmicTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
        .preferredColorScheme(.dark)
    }
}

