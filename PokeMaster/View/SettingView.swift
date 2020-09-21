//
//  SettingView.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var settings = Settings()
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            Picker(selection: $settings.accountBehavior, label: Text("")) {
                ForEach(Settings.AccountBehavior.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            TextField("电子邮箱", text: $settings.email)
            SecureField("密码", text: $settings.password)
            if settings.accountBehavior == .register {
                SecureField("确认密码", text: $settings.vefiryPassword)
            }
            Button(settings.accountBehavior.text) {
                
            }
        }
    }
    
    var optionSection: some View {
        Section(header: Text("选项")) {
            HStack {
                Toggle(isOn: $settings.showEnglishName, label: {
                    Text("显示英文名")
                })
            }
            Picker(selection: $settings.sorting, label: Text("排序方式")) {
                ForEach(Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            HStack {
                Toggle(isOn: $settings.showFavoriteOnly, label: {
                    Text("只显示收藏")
                })
            }
        }
    }
    
    var clearMemorySection: some View {
        Section {
            HStack {
                Text("清空缓存")
                    .foregroundColor(.pokemonRed)
                    .font(.subheadline)
            }
        }
    }
    
    var body: some View {
        Form {
            accountSection
            optionSection
            clearMemorySection
        }
    }
}

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView()
                .navigationTitle("设置")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView()
    }
}
