/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct TasksViewer: View {
  
  let onSave: (String, Double) -> Void
  
  @State var selection: NavigationItem?// = .main
  
  var body: some View {
    NavigationView {
      sidebar
      Text("Main")
        .foregroundColor(.secondary)
    }
  }
  
  var sidebar: some View {
    List(selection: $selection) {
      NavigationLink(destination: TasksListView() { title, duration in
        onSave(title, duration)
      },
                     tag: NavigationItem.main,
                     selection: $selection) {
        Label("Tasks", systemImage: "list.bullet")
      }
      .tag(NavigationItem.main)
      
      NavigationLink(destination: FavoritesView(),
                     tag: NavigationItem.favorites,
                     selection: $selection) {
          Label("Favorites", systemImage: "heart")
        }
        .tag(NavigationItem.favorites)
      
      NavigationLink(destination: CountupTimerView(
        timer: TimerWrapper(totalTime: 0,
                            timeInterval: 0.01,
                            direction: .up)),
                     tag: NavigationItem.stopwatch,
                     selection: $selection) {
          Label("Stopwatch", systemImage: "stopwatch")
        }
        .tag(NavigationItem.stopwatch)
      
    }
    .listStyle(SidebarListStyle())
    .toolbar {
      ToolbarItemGroup {
        Button(action: toggleSidebar) {
          Label("Toggle Sidebar", systemImage: "sidebar.left")
        }
        Button(action: createTask) {
          Label("Add New Task", systemImage: "plus")
        }
      }
    }
  }
  
  func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar), with: nil)
  }
}

extension TasksViewer {
  
  func createTask() {
    selection = .main
    onSave("New Task", 60)
  }
}

struct TasksViewer_Previews: PreviewProvider {
  static var previews: some View {
    TasksViewer() { _, _ in }
  }
}
