import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct Login {
  @State loginByPassword: boolean = true;
  private phone: string = ''
  private password: string = ''
  @State checked: boolean = false

  @Styles
  normalStyle() {
    .backgroundColor('#eee')
  }

  @Styles
  pressedStyle() {
    .backgroundColor("#33A634")
  }

  @Builder
  builderButton(text: string, callback: Function) {
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
      .onClick(() => {
        callback()
      })
  }

  build() {
    Column({ space: 16 }) {
      Image($r('app.media.app_icon')).width(120)
      if (this.loginByPassword) {
        TextInput({ placeholder: "请输入手机号" })
          .type(InputType.Number)
          .onChange((v) => {
            this.phone = v
          })
        TextInput({ placeholder: "请输入密码" })
          .type(InputType.Password)
          .onChange((v) => {
            this.password = v
          })
      } else {
        Text("189****06")
        Text('华为绑定账户号码')
      }

      Button("登录")
        .width('100%')
        .onClick(() => {
          if (!this.checked) {
            this.getUIContext().getPromptAction().showToast({
              message: "请先勾选协议",
              duration: 2000,
              showMode: promptAction.ToastShowMode.TOP_MOST,
              bottom: 80,
              backgroundColor: "red",
            })
            return
          }
          if (this.loginByPassword) {
            if (!this.password || !this.phone) {
              this.getUIContext().getPromptAction().showToast({
                message: "请输入手机号或者密码",
                duration: 2000,
                showMode: promptAction.ToastShowMode.TOP_MOST,
                bottom: 80,
                backgroundColor: "red",
              })
            }
            return
          }

          router.replaceUrl({ url: 'pages/Index' });
        })

      Row().height(40)
      this.builderButton("华为账户一键登录", () => {
        this.loginByPassword = false
      })
      this.builderButton("手机号密码登录", () => {
        this.loginByPassword = true
      })

      Row() {
        Toggle({ type: ToggleType.Checkbox, isOn: false })
          .onChange((v) => this.checked = v)

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