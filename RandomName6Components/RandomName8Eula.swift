import SwiftUI

struct RandomName8Eula: View {
  @Binding var isAgreeEula: Bool
  @Binding var isShowEula: Bool
  var body: some View {
    GeometryReader { geometry in
      Color.black.opacity(0.2).ignoresSafeArea()
      VStack(spacing: 0) {
        Spacer().frame(height: 63.h)
        Text("EULA")
          .foregroundColor(.red)
          .font(.system(size: 24.sp, weight: .black))

        Spacer().frame(height: 6.h)
        Text(
          """
          Welcome to ProjectName! To make a better place, the following content is not allowed inthe app in particular
          1.Any content about child harm, pornography related detrimental to children.
          2. Fake and harmful messages about recent or current events.
          3. Any violence,bullying content, publicly promotes pornography and other content.

          If we find any content including and not limited to the above violations your content will be deleted and account will bebanned. By clicking the above button,youagreeto the Terms of Use and Privacy Policy
          """
        )
        .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
        .font(.system(size: 14.sp, weight: .semibold))
        .lineSpacing(8)
        .padding(.horizontal, 36.w)
        Spacer()
        HStack(spacing: 23.w) {
          Button(action: {
            isAgreeEula = false
            isShowEula = false
          }) {
            Text("CANCLE")
              .foregroundColor(.white)
              .font(.system(size: 16.sp, weight: .bold))
              .frame(maxWidth: .infinity)
          }
          .frame(height: 40.h)
          .background(.white)
          .cornerRadius(20)
          Button(action: {
            isShowEula = false
            isAgreeEula = true
          }) {
            Text("I AGREE")
              .foregroundColor(.black)
              .font(.system(size: 16.sp, weight: .bold))
              .frame(maxWidth: .infinity)
          }
          .frame(height: 40.h)
          .background(
            .white
          )
          .cornerRadius(20)
        }
        .padding(.horizontal, 36.w)
        Spacer()
      }
      .frame(width: 335.w, height: 675.h)
      .background(
        Image("Assets/projectName_guide_eula_bg").resizable().scaledToFill()
      )
      .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    }
  }
}
