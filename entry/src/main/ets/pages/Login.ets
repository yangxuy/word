import { router } from '@kit.ArkUI';

@Entry
@Component
struct Login {
  @State message: string = '';

  onChangeType() {

  }

  @Styles
  normalStyle() {
    .backgroundColor('#eee')
  }

  @Styles
  pressedStyle() {
    .backgroundColor(Color.Red)
  }

  @Builder
  builderButton(text: string) {
    Button(text, { type: ButtonType.Normal })
      .width('100%')
      .height(50)
      .borderRadius(8)
      .stateStyles({
        normal: this.normalStyle,
        pressed: this.pressedStyle,
        focused: this.pressedStyle
      })
      .fontColor('#000')
      .onClick(()=>{
        router.replaceUrl({ url: 'pages/Index' });
      })
  }

  build() {
    Column({ space: 16 }) {
      Image($r('app.media.app_icon')).width(120)
      Text("189****06")
      Text('华为绑定账户号码')

      Row().height(40)

      this.builderButton("华为账户一键登录")
      this.builderButton("微信登录")
      this.builderButton("QQ登录")
      this.builderButton("其它方式登录")

      Row() {
        Radio({ value: 'Radio1', group: 'radioGroup' })
          .checked(false)
        Text('已阅读并同意《用户协议》《隐私政策》和《儿童隐私政策》')
      }.margin({
        top: 90
      })
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}