//
//  CustomNavigationView.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 29.12.2020.
//

import SwiftUI

private struct Screen: Identifiable, Equatable {
    
    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

private struct ScreenStack {
    
    private (set) var screens = [Screen]()
    
    func top() -> Screen? {
        screens.last
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
    
}


private class CustomNavigationViewModel: ObservableObject {
    @Published fileprivate var currentScreen: Screen?
    @Published private (set) var isRoot: Bool = true
    
    private var screenStack = ScreenStack() {
        didSet {
            currentScreen = screenStack.top()
        }
    }
    
    func push<S: View>(_ screenView: S) {
        withAnimation(.easeOut(duration: 0.33)) {
            let screen = Screen(id: UUID().uuidString, nextScreen: AnyView(screenView))
            screenStack.push(screen)
            updateRootState()
        }
    }
    
    func pop() {
        withAnimation(.easeOut(duration: 0.33)) {
            screenStack.popToPrevious()
            updateRootState()
        }
    }
    
    private func updateRootState() {
        isRoot = screenStack.screens.isEmpty
    }
}

struct CustomNavigationView<T: View>: View {
    @ObservedObject private var vm = CustomNavigationViewModel()
    
    private let content: T
    
    init(@ViewBuilder content: @escaping () -> T) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            NavigationBarView()
                .environmentObject(vm)
            ZStack {
                if vm.isRoot {
                    content
                        .transition(AnyTransition.opacity.combined(with: .move(edge: .leading)))
                        .environmentObject(vm)
                } else {
                    vm.currentScreen!.nextScreen
                        .transition(AnyTransition.opacity.combined(with: .move(edge: .leading)))
                        .environmentObject(vm)
                }
            }
        }
        
    }
}

struct NavigationBarView: View {
    @EnvironmentObject private var viewModel: CustomNavigationViewModel
    
    var body: some View {
        ZStack {
            HStack(content: {
                Button("Back") {
                    viewModel.pop()
                }
                    .opacity(viewModel.isRoot ? 0 : 1)
                    .disabled(viewModel.isRoot)
                Spacer()
            })
            Text("Placeholder")
        }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        Divider()
    }
    
}

struct CustomNavigationLink<Label, Destination> : View where Label : View, Destination : View {
    @EnvironmentObject private var viewModel: CustomNavigationViewModel
    
    private let destination: Destination
    private let label: Label
    
    init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        label.onTapGesture {
            viewModel.push(destination)
        }
    }
    
}

public struct NavPushButton<Label, Destination>: View where Label: View, Destination: View {
    
    @EnvironmentObject private var viewModel: CustomNavigationViewModel
    
    private let destination: Destination
    private let label: Label
    
    public init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    public var body: some View {
        label.onTapGesture {
            push()
        }
    }
    
    private func push() {
        viewModel.push(destination)
    }
    
}
