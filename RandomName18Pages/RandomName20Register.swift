import SwiftUI

struct RandomName20Register: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  enum Field: Hashable {
    case email
    case password
    case againPassword
  }
  @State var email: String = ""
  @State var password: String = ""
  @State var againPassword: String = ""
  @FocusState private var focusedField: Field?
  @EnvironmentObject var router: RandomName16Router
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { geometry in
      Image("DefaultBg").resizable().scaledToFill().ignoresSafeArea()
      Image("Assets/projectName_sign_rw").resizable().scaledToFit().frame(
        width: 59.w, height: 116.h
      )
      .frame(maxHeight: .infinity, alignment: .topLeading).offset(x: 53.w, y: 34.h)
      VStack(spacing: 0) {
        Spacer().frame(height: 145.h)
        TextField(
          "", text: $email,
          prompt: Text("Email")
            .foregroundColor(Color.white.opacity(0.5))
            .font(.system(size: 16.sp)),
        )
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .font(.system(size: 16.sp))
        .foregroundColor(Color.white)
        .padding(.horizontal, 16.w)
        .padding(.vertical, 20.h)
        .padding(.leading, 30.w)
        .background(
          .white
        )
        .cornerRadius(40.r)
        .overlay(
          Image("Assets/projectName_email_icon").resizable().scaledToFit().frame(
            width: 24.r, height: 24.r
          ).offset(x: 16.w),
          alignment: .leading
        )
        .focused($focusedField, equals: .email)
        .submitLabel(.next)
        .onSubmit {
          focusedField = .password
        }
        Spacer().frame(height: 24.h)
        SecureField(
          "", text: $password,
          prompt: Text("Password")
            .foregroundColor(Color.white.opacity(0.5))
            .font(.system(size: 16.sp)),
        )
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .font(.system(size: 16.sp))
        .foregroundColor(Color.white)
        .padding(.horizontal, 16.w)
        .padding(.vertical, 20.h)
        .padding(.leading, 30.w)
        .background(
          .white
        )
        .cornerRadius(40.r)
        .overlay(
          Image("Assets/projectName_password_icon").resizable().scaledToFit().frame(
            width: 24.r, height: 24.r
          ).offset(x: 16.w),
          alignment: .leading
        )
        .focused($focusedField, equals: .password)
        .submitLabel(.next)
        .onSubmit {
          focusedField = .againPassword
        }
        Spacer().frame(height: 24.h)
        SecureField(
          "", text: $againPassword,
          prompt: Text(" Enter the password again")
            .foregroundColor(Color.white.opacity(0.5))
            .font(.system(size: 16.sp)),
        )
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .font(.system(size: 16.sp))
        .foregroundColor(Color.white)
        .padding(.horizontal, 16.w)
        .padding(.vertical, 20.h)
        .padding(.leading, 30.w)
        .background(
          .white
        )
        .cornerRadius(40.r)
        .overlay(
          Image("Assets/projectName_password_icon").resizable().scaledToFit().frame(
            width: 24.r, height: 24.r
          ).offset(x: 16.w),
          alignment: .leading
        )
        .focused($focusedField, equals: .againPassword)
        .submitLabel(.done)
        .onSubmit {
          focusedField = nil
        }
        Spacer()
        Text("SIGN UP")
          .foregroundColor(.white)
          .font(.system(size: 20.sp, weight: .bold))
          .frame(height: 53.h)
          .frame(maxWidth: .infinity)
          .background(
            Color.white
          )
          .cornerRadius(40)
          .padding(.horizontal, 58.w)
        Spacer()
      }
      .padding(.horizontal, 30.w)
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          router.projectNamePath.removeLast()
        } label: {
          Image("Assets/projectName_back")
            .resizable()
            .scaledToFit()
            .frame(width: 40.r, height: 40.r)
        }
      }
      ToolbarItem(placement: .navigationBarLeading) {
        Text("SIGN UP")
          .foregroundColor(.red)
          .font(.system(size: 24.sp, weight: .black))

      }
    }
    .navigationBarBackButtonHidden(true)
    .enableSwipeBack()
    .enableInjection()
  }
}
