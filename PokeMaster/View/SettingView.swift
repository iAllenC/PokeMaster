//
//  SettingView.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var store: Store
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            if let user = settings.loginUser {
                Text(user.email)
                Button("注销") {
                    store.dispatch(.logout)
                }
            } else {
                Picker(selection: settingsBinding.checker.accountBehavior, label: Text("")) {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("电子邮箱", text: settingsBinding.checker.email)
                    .foregroundColor(settings.isEmailValid ? .pokemonGreen : .pokemonRed)
                SecureField("密码", text: settingsBinding.checker.password)
                if settings.checker.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.checker.verifyPassword)
                }
                if settings.loginRequesting || settings.registerRequesting {
                    IndicatorView(color: .black)
                } else {
                    Button(settings.checker.accountBehavior.text) {
                        if settings.checker.accountBehavior == .login {
                            store.dispatch(.login(email: settings.checker.email, password: settings.checker.password))
                        } else {
                            store.dispatch(.register(email: settings.checker.email, password: settings.checker.password))

                        }
                    }
                    .disabled(
                        (settings.checker.accountBehavior == .login && !settings.isLoginValid) ||
                            (settings.checker.accountBehavior == .register && !settings.isRegisterValid))
                }
            }
        }
    }
    
    var optionSection: some View {
        Section(header: Text("选项")) {
            HStack {
                Toggle(isOn: settingsBinding.showEnglishName, label: {
                    Text("显示英文名")
                })
            }
            Picker(selection: settingsBinding.sorting, label: Text("排序方式")) {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            HStack {
                Toggle(isOn: settingsBinding.showFavoriteOnly, label: {
                    Text("只显示收藏")
                })
            }
        }
    }
    
    var clearMemorySection: some View {
        Section {
            HStack {
                Button(action: {
                    store.dispatch(.cleanCache)
                }, label: {
                    Text("清空缓存")
                        .foregroundColor(.pokemonRed)
                        .font(.subheadline)
                })
            }
        }
    }
    
    var body: some View {
        Form {
            accountSection
            optionSection
            clearMemorySection
        }
        .alert(item: settingsBinding.loginError) {
            Alert(title: Text($0.localizedDescription))
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

extension AppState.Settings.Sorting {
    
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
    
}

extension AppState.Settings.AccountBehavior {
    
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
    
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView().environmentObject(Store())
    }
}
