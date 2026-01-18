import SwiftUI

struct FirstAccessBottomSheetView: View {
    @Binding var isShowing: Bool
    @State private var yOffset: CGFloat = 1000
    @State private var rewardScale: CGFloat = 0.9

    var didCloseBottomSheet: () -> Void

    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .onTapGesture {
                    close()
                }

            VStack {
                Spacer()

                VStack(spacing: 16) {
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 50, height: 5)
                        .padding(.top, 12)

                    Text("Welcome to Pokédex!")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Keep active to capture them all!")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)

                    Text("Walk more. Earn more Poké Balls.")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    VStack(spacing: 12) {
                        Text("Daily Rewards")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)

                        Image("firstAccessStepsInfo")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(rewardScale)
                            .onAppear {
                                withAnimation(
                                    .spring(response: 0.45, dampingFraction: 0.6)
                                ) {
                                    rewardScale = 1
                                }
                            }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemGray6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.red.opacity(0.25), lineWidth: 2)
                            )
                    )
                    .padding(.horizontal)

                    ImageButton(
                        text: "Let’s Go!",
                        backgroundColor: .red
                    ) {
                        close()
                    }
                    .padding(.top, 8)
                    .padding(.bottom)
                }
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .roundSpecificCorners(
                            radius: 25,
                            corners: [.topLeft, .topRight]
                        )
                )
                .offset(y: yOffset)
                .animation(.easeOut(duration: 0.4), value: yOffset)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.height > 120 {
                                close()
                            }
                        }
                )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeOut(duration: 0.4)) {
                yOffset = 0
            }
        }
    }

    private func close() {
        withAnimation(.easeIn(duration: 0.3)) {
            yOffset = 1000
        } completion: {
            isShowing = false
            didCloseBottomSheet()
        }
    }
}

#Preview {
    FirstAccessBottomSheetView(
        isShowing: .constant(true),
        didCloseBottomSheet: {}
    )
}
